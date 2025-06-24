Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5809291C35;
	Tue, 24 Jun 2025 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750790990; cv=none; b=WvKRyg5aXCEZpdK+7ZAJAMYfj/A3k3zfBRVuKdXWVro3FUEinFngpmhj7vILUAXqiTEml6lCEdYLl1OuHi5PUnAaq7ZNQqej3yqBQ6hoIBI1ZsyUVGg4Z6DedPcNsEx/U4HmGsLS4tGGclAX4GvCS6NhxuB132hWCeY7xyvYlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750790990; c=relaxed/simple;
	bh=9kF6v6N0JCqKUGtvLVZOnT/9T5ph+mbZpi1APXwKSww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUHYwKhccZRm90xGmoJlWS7gDzvjnizjSx1G2x0iWjcp8j559ch1uz+AwPGkMOKxmyPzDFo3OBSP+uPWzCoAPUFlelaeXIlSC+NkaHpmVAuuPs8f2sM0jtc6BSfKSJ4ESEj2jlgI9CmbtimV0EU6nqN+/EWot8S1ONWa3lu5a9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwKd+6TN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwKd+6TN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4932C4CEE3;
	Tue, 24 Jun 2025 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750790989;
	bh=9kF6v6N0JCqKUGtvLVZOnT/9T5ph+mbZpi1APXwKSww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwKd+6TNTeMYGRQ75w+oomqUvGxfrIUxv07KJXWVtjyz667Sngv0LLmkhP6S9/2YB
	 17KopHlrUvOZ5ALEvOESNhgqV7NuB2LEt3utPB33unBBD/2GAVtcuAGF5ER+EvtisB
	 9UeStSiMXNUrRoiKuJwAsTuI5NPvPs878BYlR/wC7XZBcDe5Uw/z2Dh5O2O3XW+iJl
	 AosOxJ44RMoW/JQAHnIBi+7n8KyLXXXWE3Rtr08aURQ0hM+3uMsmGm2ixYoktmzfVb
	 gSTfOCU++Zo5yRXIo8qogwXg8usYG3EoJKJIX3flhqI81/Q8YSf6qHiGB/pR55K13d
	 6h073Ktim3Jig==
Date: Tue, 24 Jun 2025 11:49:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tianyou Li <tianyou.li@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, wangyang.guo@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add --buildids-blacklist option to perf archive command
Message-ID: <aFrzSpvzzWeHdyJ5@google.com>
References: <20250609035542.2364525-1-tianyou.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250609035542.2364525-1-tianyou.li@intel.com>

Hello,

On Mon, Jun 09, 2025 at 11:55:42AM +0800, Tianyou Li wrote:
> When make a perf archive, it may contains the binaries that user did not want to ship with,
> add --buildids-blacklist option to specify a backlist file which contains the buildids need
> to be excluded. The blacklist file can be generated from command:
> 
>   perf buildid-list -i perf.data --with-hits | grep -v "^ " > buildids_blacklist.txt
> 
> Then remove the lines from the buildids_blacklist.txt for buildids should be included.

Instead of blacklist, how about saying it like "--exclude-buildids"?

> 
> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> ---
>  tools/perf/perf-archive.sh | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
> index 6ed7e52ab881..e5ff840ac6b4 100755
> --- a/tools/perf/perf-archive.sh
> +++ b/tools/perf/perf-archive.sh
> @@ -16,6 +16,13 @@ while [ $# -gt 0 ] ; do
>  	elif [ $1 == "--unpack" ]; then
>  		UNPACK=1
>  		shift
> +	elif [ $1 == "--buildids-blacklist" ]; then
> +		BUILDIDS_BLACKLIST="$2"
> +		if [ ! -e "$BUILDIDS_BLACKLIST" ]; then
> +			echo "Provided buildids blacklist file $BUILDIDS_BLACKLIST does not exist"
> +			exit 1
> +		fi
> +		shift 2
>  	else
>  		PERF_DATA=$1
>  		UNPACK_TAR=$1
> @@ -86,11 +93,29 @@ fi
>  
>  BUILDIDS=$(mktemp /tmp/perf-archive-buildids.XXXXXX)
>  
> -perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " > $BUILDIDS
> -if [ ! -s $BUILDIDS ] ; then
> -	echo "perf archive: no build-ids found"
> -	rm $BUILDIDS || true
> -	exit 1
> +#
> +# BUILDIDS_BLACKLIST is an optional file that contains build-ids to be excluded from the
> +# archive. It is a list of build-ids, one per line, without any leading or trailing spaces.
> +# If the file is empty, all build-ids will be included in the archive. To create a blacklist
> +# file, you can use the following command:
> +# 	perf buildid-list -i perf.data --with-hits | grep -v "^ " > buildids_blacklist.txt
> +# You can edit the file to remove the lines that you want to keep in the archive, then:
> +# 	perf archive --buildids-blacklist buildids_blacklist.txt

Then you'll need to update the comment here.

Thanks,
Namhyung

> +#
> +if [ ! -s $BUILDIDS_BLACKLIST ]; then
> +	perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " > $BUILDIDS
> +	if [ ! -s $BUILDIDS ] ; then
> +		echo "perf archive: no build-ids found"
> +		rm $BUILDIDS || true
> +		exit 1
> +	fi
> +else
> +	perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " | grep -Fv -f $BUILDIDS_BLACKLIST > $BUILDIDS
> +	if [ ! -s $BUILDIDS ] ; then
> +		echo "perf archive: no build-ids found after applying blacklist"
> +		rm $BUILDIDS || true
> +		exit 1
> +	fi
>  fi
>  
>  MANIFEST=$(mktemp /tmp/perf-archive-manifest.XXXXXX)
> -- 
> 2.47.1
> 
