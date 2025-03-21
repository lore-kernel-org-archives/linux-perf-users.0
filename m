Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E001E98E1
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537095; cv=none; b=OZfcQ2ogN0n2osgHpV84mYAb6CteOMZ0LJYLdpjYbVR1NgBJTToCDIXZxJsEfiC4r5CybmsjTwpp4Bn5ymYJ+HVqhqo3fXit4aSg8Qk4+IYTw1VEHr8w6VCSm6XDmhhCVixXUsKcgSaSJnaqTRpTAOhD0VOHXihV3QQB9LgRZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537095; c=relaxed/simple;
	bh=YTOfT2AgvJ3xym+OkMxs576dW5ZyAjVozPTJ372YQ+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJstft1a/dz2NaUjcQBBW7adgOo0YBAXTFgY+eNEx1rJnQ0NfYvXQU30zRWCxi8dkz6g1f2QuROgaLsCNEzQMjDyBbhUy6tDF+qB4r1ooSwdupY9LWRBhxF57r7thxKcbWbHAfv6oAwoAFYGtJKXq8GHZfuORZ+EMXsHnZtw6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp6ekipl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp6ekipl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E474C4CEE8;
	Fri, 21 Mar 2025 06:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742537094;
	bh=YTOfT2AgvJ3xym+OkMxs576dW5ZyAjVozPTJ372YQ+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yp6ekipl41EwEE06dN2slt0SblXzUl5GHuaxN/ANkrGsK0n7FM3NhRksCmAeCOolL
	 bUpxWojQoG3iNWFC9eK+dGM4Q/6F/1kVsbW25CvObh8S0VfMxA6yfXEX4UWL/7+DUm
	 MsbKvyUJJUPeHl2qBJYplqwU/JiqJvLB0ShaAN0IMDzQl8L57QNquVcR6G0ffQkN/S
	 A2su16HOB9gLHCPTHslIulMAx2C+6CmSvrpOg9DU9YdKUiF9VkrhDcj/11d1lyKazD
	 ZR9TqYyMLyCGV9wwrwZ6luv3usvMmBaCg8nMnQFW4Lk08fgWFo2hZdcKSPgOC12eHR
	 4adqg6QsQUvPQ==
Date: Thu, 20 Mar 2025 23:04:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aditya Bodkhe <adityab1@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, Disha Goel <Disha.Goel@ibm.com>,
	Aditya Bodkhe <aditya.b1@linux.ibm.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf script: perf script tests fails with segfault
Message-ID: <Z90BhWbDJjR15_6q@google.com>
References: <20250320091551.17846-1-adityab1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250320091551.17846-1-adityab1@linux.ibm.com>

CC-ing Adrian,

On Thu, Mar 20, 2025 at 02:45:51PM +0530, Aditya Bodkhe wrote:
> perf script: pert script tests fails with segmentation fault as below:
> 
> 1. Run perf test -vvv 'perf script tests'
> 
> 	 92: perf script tests:
> 	--- start ---
> 	test child forked, pid 103769
> 	DB test
> 	[ perf record: Woken up 1 times to write data ]
> 	[ perf record: Captured and wrote 0.012 MB /tmp/perf-test-script.7rbftEpOzX/perf.data (9 samples) ]
> 	/usr/libexec/perf-core/tests/shell/script.sh: line 35: 103780 Segmentation fault      (core dumped) perf script -i "${perfdatafile}" -s "${db_test}"
> 	--- Cleaning up ---
> 	---- end(-1) ----
>  	92: perf script tests                                               : FAILED!
> 
> Backtrace pointed to :
> 	#0  0x0000000010247dd0 in maps.machine ()
> 	#1  0x00000000101d178c in db_export.sample ()
> 	#2  0x00000000103412c8 in python_process_event ()
> 	#3  0x000000001004eb28 in process_sample_event ()
> 	#4  0x000000001024fcd0 in machines.deliver_event ()
> 	#5  0x000000001025005c in perf_session.deliver_event ()
> 	#6  0x00000000102568b0 in __ordered_events__flush.part.0 ()
> 	#7  0x0000000010251618 in perf_session.process_events ()
> 	#8  0x0000000010053620 in cmd_script ()
> 	#9  0x00000000100b5a28 in run_builtin ()
> 	#10 0x00000000100b5f94 in handle_internal_command ()
> 	#11 0x0000000010011114 in main ()
> 
> Further investigation reveals that this occurs in the `perf script tests`,
> because it uses `db_test.py` script. This script sets `perf_db_export_mode = True`.
> 
> With `perf_db_export_mode` enabled, if a sample originates from a hypervisor,
> perf doesn't set maps for “[H]” sample in the code. Consequently, `al->maps` remains NULL
> when `maps__machine(al->maps)` is called from `db_export__sample`.
> 
> To prevent this NULL pointer dereference, add a check for `al->maps == NULL`
> before calling `maps__machine()`. If `al->maps` is NULL, return `-1` to avoid
> the segmentation fault.
> 
> Reported-by: Disha Goel <Disha.Goel@ibm.com>
> Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>
> ---
>  tools/perf/util/db-export.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
> index 50f916374d87..f355878a8c82 100644
> --- a/tools/perf/util/db-export.c
> +++ b/tools/perf/util/db-export.c
> @@ -365,6 +365,11 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
>         if (err)
>                 return err;
> 
> +       if (!al->maps) {
> +          err = -1;
> +          goto out_put;
> +       }

Maybe better to check it before db_export__evsel().  Also it seems it
should not goto out_put as it doesn't get the main_thread yet.

Thanks,
Namhyung

> +
>         machine = maps__machine(al->maps);
>         err = db_export__machine(dbe, machine);
>         if (err)
> -- 
> 2.43.0
> 
