Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556E07D8AD
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1vVQmu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9FDC433C8;
	Tue, 12 Dec 2023 18:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702404410;
	bh=cDFySboCHmgRX3Hzcfrph6aaK8Yk+cyns8x2rRA4VHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1vVQmu4R5dsCZj6MTIc5bPwi6iN78DOiEzf/E2Wd/5Ixe3n1PDaJ/5C/O/RxdNSX
	 0POKuvDnlL7O6gkWWrqVMGvZWsbXDEje7njX0IOHLwXU/HpNp4bOYrOM1n49SjfW9y
	 WvdaZOKcXolSHOIZWpiRgiV4R2M4x9rLaJXjIBcvlYAGX3M5CZluRI8IzJNF1JjMUi
	 7RKso8j+JSJ2Jxj5tWmwp/6F2zFM4lqZJo4UOOP4YKD/KdnGjEooa3RkveWtAVemfR
	 C5u1lnStlWsaHy8z6Lf4d9F3CmIo3XMSx92yUcpLA+wVWXOpS0Q5pvQ5+7huMLyQ89
	 s2aG5gY1h5XzQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 7E39C403EF; Tue, 12 Dec 2023 15:06:47 -0300 (-03)
Date: Tue, 12 Dec 2023 15:06:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com
Subject: Re: [PATCH 1/2] perf archive: Add new option '--all'
Message-ID: <ZXihN3th3qbo6L8Z@kernel.org>
References: <20231212165909.14459-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212165909.14459-1-vmolnaro@redhat.com>
X-Url: http://acmel.wordpress.com

Em Tue, Dec 12, 2023 at 05:59:08PM +0100, vmolnaro@redhat.com escreveu:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Perf archive has limited functionality and people from Red Hat Global
> Support Services sent a request for a new feature that would pack
> perf.data file together with an archive with debug symbols created by
> the command 'perf archive' as customers were being confused and often
> would forget to send perf.data file with the debug symbols.
> 
> Perf archive now accepts an option '--all' that generates archive
> 'perf.all-hostname-date-time.tar.bz2' that holds file 'perf.data' and
> a sub-tar 'perf.symbols.tar.bz2' with debug symbols. The functionality of
> the command 'perf archive' was not changed.

Thanks for working on this, I'll do some testing and apply, probably
tomorrow.

- Arnaldo
 
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> ---
>  tools/perf/perf-archive.sh | 40 ++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
>  mode change 100644 => 100755 tools/perf/perf-archive.sh
> 
> diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
> old mode 100644
> new mode 100755
> index 133f0eddbcc4..a92042eae95a
> --- a/tools/perf/perf-archive.sh
> +++ b/tools/perf/perf-archive.sh
> @@ -4,9 +4,19 @@
>  # Arnaldo Carvalho de Melo <acme@redhat.com>
>  
>  PERF_DATA=perf.data
> -if [ $# -ne 0 ] ; then
> -	PERF_DATA=$1
> -fi
> +PERF_SYMBOLS=perf.symbols
> +PERF_ALL=perf.all
> +ALL=0
> +
> +while [ $# -gt 0 ] ; do
> +	if [ $1 == "--all" ]; then
> +		ALL=1
> +		shift
> +	else
> +		PERF_DATA=$1
> +		shift
> +	fi
> +done
>  
>  #
>  # PERF_BUILDID_DIR environment variable set by perf
> @@ -39,9 +49,23 @@ while read build_id ; do
>  	echo ${filename#$PERF_BUILDID_LINKDIR} >> $MANIFEST
>  done
>  
> -tar cjf $PERF_DATA.tar.bz2 -C $PERF_BUILDID_DIR -T $MANIFEST
> -rm $MANIFEST $BUILDIDS || true
> -echo -e "Now please run:\n"
> -echo -e "$ tar xvf $PERF_DATA.tar.bz2 -C ~/.debug\n"
> -echo "wherever you need to run 'perf report' on."
> +if [ $ALL -eq 1 ]; then						# pack perf.data file together with tar containing debug symbols
> +	HOSTNAME=$(hostname)
> +	DATE=$(date '+%Y%m%d-%H%M%S')
> +	tar cjf $PERF_SYMBOLS.tar.bz2 -C $PERF_BUILDID_DIR -T $MANIFEST
> +	tar cjf	$PERF_ALL-$HOSTNAME-$DATE.tar.bz2 $PERF_DATA $PERF_SYMBOLS.tar.bz2
> +	rm $PERF_SYMBOLS.tar.bz2 $MANIFEST $BUILDIDS || true
> +
> +	echo -e "Now please run:\n"
> +	echo -e "$ tar xvf $PERF_ALL-$HOSTNAME-$DATE.tar.bz2 && tar xvf $PERF_SYMBOLS.tar.bz2 -C ~/.debug\n"
> +	echo "wherever you need to run 'perf report' on."
> +else										# pack only the debug symbols
> +	tar cjf $PERF_DATA.tar.bz2 -C $PERF_BUILDID_DIR -T $MANIFEST
> +	rm $MANIFEST $BUILDIDS || true
> +
> +	echo -e "Now please run:\n"
> +	echo -e "$ tar xvf $PERF_DATA.tar.bz2 -C ~/.debug\n"
> +	echo "wherever you need to run 'perf report' on."
> +fi
> +
>  exit 0
> -- 
> 2.43.0
> 

-- 

- Arnaldo
