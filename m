Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0B41AAC;
	Tue, 10 Jun 2025 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749518394; cv=none; b=B/PXkplDNfHqUFSciwmRmWxn2fbfms2Q3xPaaTBaKo097PGGFPsiNWL6lTWupcqrPrGrkI46ldRn6kvA8Pa/52IkuJQbnZElRHA+mZb3/v4cUhuje9WY0p9DrWLor1sd6x7LIfNyH/hIiZZdHbp7XVQu8kYpWw0eiLTC1pblRGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749518394; c=relaxed/simple;
	bh=53Vo2R573voEg/pugPpL3dxKV+jtB1szute4QK9AIa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7S5ACSHC7P6uVW2jUENxVYo96qOC3/FGr9voXb//dxuKrYS7e9tP85AdKUDGdGJxOoZYj3gPkMzIJoptjkDcwC5kMB/1AH1rYmIAopVtNbRTVliu430G2AXcQ89jMhFJBPV+llaPXkHihlIE77RvpapLZiRTID+eYYwBY56FPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfQahuhA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfQahuhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39420C4CEEB;
	Tue, 10 Jun 2025 01:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749518393;
	bh=53Vo2R573voEg/pugPpL3dxKV+jtB1szute4QK9AIa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XfQahuhA8Iu5JtWfeODCx+V73RWVOYFohGq2a05CRg0QrPfgENPLxGq3mleE/ZoSG
	 HMlmMOM7ULrql75nbfvWLwEWaMzu+DZNyZ1v9ZaK/5by2XAPOwoDwFizWV2CT+CjCg
	 Q0DpHCtfR1dmLfTdr8TUNIpEE7d2V258z1m+clZKTzmts/zzgxYrDUFGlacHWHw/jE
	 ExhRgDCBOaifUZmkv7jwWkKW8gOoY/uDjPmQZxfGHEuKGVZmwrC6ru9ZPapS5u5emD
	 7zQVdQz8AlKidB1UW0gU+s4FdptsbCDuXDlNEvmoXCfNA7Yohb3I2g3WRJ7/A0egPR
	 Rau8ZHYEdALfw==
Date: Mon, 9 Jun 2025 18:19:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tianyou Li <tianyou.li@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, wangyang.guo@intel.com,
	pan.deng@intel.com, zhiguo.zhou@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor improvements for perf script flamegraph
Message-ID: <aEeIN_u4KpLZXDBx@google.com>
References: <20250603071048.180674-1-tianyou.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603071048.180674-1-tianyou.li@intel.com>

Hello,

On Tue, Jun 03, 2025 at 03:10:48PM +0800, Tianyou Li wrote:
> When processing the perf data file generated with multiple events,
> the flamegraph script will count all the events regardless of
> different event names. If specify the perf data file with -i option,
> the script will try to read the header information regardless of
> the file name specified, instead it will try to access the perf.data.
> 
> This patch tries to add a -e option to specify the event name that
> the flamegraph will be generated accordingly. If the -e option omitted,
> the behavior remains unchanged. If the -i option specified, the header
> information will be read from that file.

Looks like two separate changes.  Can you please split them?

Thanks,
Namhyung

> 
> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> Reviewed-by: Pan Deng <pan.deng@intel.com>
> Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  tools/perf/scripts/python/flamegraph.py | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> index cf7ce8229a..eb78b93925 100755
> --- a/tools/perf/scripts/python/flamegraph.py
> +++ b/tools/perf/scripts/python/flamegraph.py
> @@ -94,6 +94,11 @@ class FlameGraphCLI:
>          return child
>  
>      def process_event(self, event):
> +        # ignore events where the event name does not match
> +        # the one specified by the user
> +        if self.args.event_name and event.get("ev_name") != self.args.event_name:
> +            return
> +
>          pid = event.get("sample", {}).get("pid", 0)
>          # event["dso"] sometimes contains /usr/lib/debug/lib/modules/*/vmlinux
>          # for user-space processes; let's use pid for kernel or user-space distinction
> @@ -123,8 +128,15 @@ class FlameGraphCLI:
>              return ""
>  
>          try:
> -            output = subprocess.check_output(["perf", "report", "--header-only"])
> -            return output.decode("utf-8")
> +            if self.args.input:
> +                output = subprocess.check_output(["perf", "script", "--header-only", "-i", self.args.input])
> +            else:
> +                output = subprocess.check_output(["perf", "report", "--header-only"])
> +
> +            result = output.decode("utf-8")
> +            if self.args.event_name:
> +                result += "\nFocused event: " + self.args.event_name
> +            return result
>          except Exception as err:  # pylint: disable=broad-except
>              print("Error reading report header: {}".format(err), file=sys.stderr)
>              return ""
> @@ -235,6 +247,11 @@ if __name__ == "__main__":
>                          default=False,
>                          action="store_true",
>                          help="allow unprompted downloading of HTML template")
> +    parser.add_argument("-e", "--event",
> +                        default="",
> +                        dest="event_name",
> +                        type=str,
> +                        help="specify the event to generate flamegraph for")
>  
>      cli_args = parser.parse_args()
>      cli = FlameGraphCLI(cli_args)
> -- 
> 2.43.5
> 
