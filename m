Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C1B8827;
	Fri, 12 Jul 2024 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720758916; cv=none; b=bqqecV/oQd33K5oD46RGUL93UoEdP1Y6XWfpwfBqeNAOxdSPUZme7OLW0vp0LuYjddJEkpZ0kKgJCL1MO1NLz/sEsf+vSHRN2Qm+1Fb1uknmvlr5cBdhLd1wFey1wPyUvsd9c7kL+USiKxOF+Qtcmakvs4bGNpgR0PVjdfaK8gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720758916; c=relaxed/simple;
	bh=l+NqoaehOUCCQ0xBsEPjk1k7Z22GY8CLnO+ZstRIgZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ako/5MLtOcnq3s4VmeClIpj/cmGZvXl1y17Frn4ZMCa0Df0gg8czj+SsJE4GU8CTwKLfWMjVxL6b3km9DgAl91CqpTMCKBRm8Cw7cmnMMzotnjqc7+4qhthZud8k52O4ZCOMD1TiApY1qeI6X694zrNF3JybZqp8SSPwQ48L9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9o1A6q+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9o1A6q+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F9AC3277B;
	Fri, 12 Jul 2024 04:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720758916;
	bh=l+NqoaehOUCCQ0xBsEPjk1k7Z22GY8CLnO+ZstRIgZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t9o1A6q+h9gfh6Zk3zx2p901TYE8GNRTWyiG2Lm4NNe9PGVTxJJ4isd3tlheqClQg
	 6pDKRacGHccEFZtIJoylxnuMp/QeXqySa+FakZtS57ORaHB/vaWzd1mxC0LWBmOYHX
	 E0fZtssto4to3ULEUBENIX5U3gE7TRkVrXFOQ3OFZ2Ot6pB1oOnb5lT7rGBJIXJssf
	 45rmebyK2Uf0kPdpOLXBUO+OCcfAK6LohGilklgrAPJPqc9108ShiTbwMYII5XPB3m
	 wmw+Z3UwQ0pqb7YNDWz+iPwGGnmZDTQge6w6ijZDS7kJ9sHGiR4iqlY5NFevxSV+l3
	 yic5iuGh6lIwg==
Date: Thu, 11 Jul 2024 21:35:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Haoze Xie <royenheart@gmail.com>
Cc: vmolnaro@redhat.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH 1/1] perf archive: unpack to correct dir given by perf
Message-ID: <ZpCyf6ulH-8dRBu4@google.com>
References: <cover.1720372219.git.royenheart@gmail.com>
 <18fa10628f1e037753244b438b2a08b20d611135.1720372219.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18fa10628f1e037753244b438b2a08b20d611135.1720372219.git.royenheart@gmail.com>

Hello,

On Mon, Jul 08, 2024 at 02:04:31AM +0800, Haoze Xie wrote:
> In perf-archive.sh, the code segment that defines 'PERF_BUILDID_DIR' is
> advanced before 'unpack' operation for subsequent use, followed by a
> 'mkdir' operation to ensure that the dir exists. Symbols in 'unpack' will
> be extracted to correct dir given by perf.
> 
> When '--unpack' param is appointed, the symbols are extracted to '~/.debug'
> folder by default, without using 'PERF_BUILDID_DIR' given by perf. This
> will cause perf to be unable to find the correct buildid's path when users
> configured buildid.dir in 'perf config' or used '--buildid-dir' cli param,
> since perf will read these params and put them in 'PERF_BUILDID_DIR' env.
> 'perf script' and 'perf report' will use the env as the basis for buildid
> indexing.

Can you please add an example command line and the output for the error
case?  It'd be helpful to understand the problem more intuitively.

> 
> Fixes: e43c64c971e4 ("perf archive: Add new option '--unpack' to expand tarballs")
> Signed-off-by: Haoze Xie <royenheart@gmail.com>
> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
> ---
>  tools/perf/perf-archive.sh | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
> index 6ed7e52ab881..f29bbc129056 100755
> --- a/tools/perf/perf-archive.sh
> +++ b/tools/perf/perf-archive.sh
> @@ -23,6 +23,19 @@ while [ $# -gt 0 ] ; do
>  	fi
>  done
>  
> +#
> +# PERF_BUILDID_DIR environment variable set by perf
> +# path to buildid directory, default to $HOME/.debug
> +#
> +if [ -z $PERF_BUILDID_DIR ]; then
> +	PERF_BUILDID_DIR=~/.debug/
> +else
> +	# append / to make substitutions work
> +	PERF_BUILDID_DIR=$PERF_BUILDID_DIR/
> +fi
> +
> +mkdir -p $PERF_BUILDID_DIR
> +
>  if [ $UNPACK -eq 1 ]; then
>  	if [ ! -z "$UNPACK_TAR" ]; then					# tar given as an argument
>  		if [ ! -e "$UNPACK_TAR" ]; then
> @@ -65,25 +78,14 @@ if [ $UNPACK -eq 1 ]; then
>  		fi
>  
>  		# unzip the perf.data file in the current working directory	and debug symbols in ~/.debug directory
> -		tar xvf $TARGET && tar xvf $PERF_SYMBOLS.tar.bz2 -C ~/.debug
> +		tar xvf $TARGET && tar xvf $PERF_SYMBOLS.tar.bz2 -C $PERF_BUILDID_DIR
>  
>  	else																# perf tar generated by perf archive (contains only debug symbols)

Off-topic.  I'm surprised by the comment placement.
It'd be nice if you (or someone else) can update the whole file and
remove the unnecessary whitespaces altogether.

Thanks,
Namhyung


> -		tar xvf $TARGET -C ~/.debug
> +		tar xvf $TARGET -C $PERF_BUILDID_DIR
>  	fi
>  	exit 0
>  fi
>  
> -#
> -# PERF_BUILDID_DIR environment variable set by perf
> -# path to buildid directory, default to $HOME/.debug
> -#
> -if [ -z $PERF_BUILDID_DIR ]; then
> -	PERF_BUILDID_DIR=~/.debug/
> -else
> -        # append / to make substitutions work
> -        PERF_BUILDID_DIR=$PERF_BUILDID_DIR/
> -fi
> -
>  BUILDIDS=$(mktemp /tmp/perf-archive-buildids.XXXXXX)
>  
>  perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " > $BUILDIDS
> -- 
> 2.25.1
> 
