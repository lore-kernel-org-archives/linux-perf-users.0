Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA0134AB
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Feb 2025 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499203; cv=none; b=Pv8N1Bz3zZByjXjNtDIHV2vjYv03XwNnSuEtxTfRDq+b2AUs5HPx4rUmFhJOAGKAXAgETRt08mLw6DEBQJZGjDHIsyl03K4tYk7xfYgz95HxPQWPCxlsBFWN5FLiNJhaVpA9ZWcBmlWPR1dQQVWQhrBoEVlVchXrsc+3orirJ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499203; c=relaxed/simple;
	bh=vqgvcgcjx+dC6CHP2eUMps/+OkBKiiVn+ocDZ7YjXtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nx+6jQLpQeDtwdQlxqLNHE6WO7YU2k7KqWiVC2048sTbvnEM9iZuGEScyJos2zv8fvpL/bRPbmA4Ex83heQnLNyh3atBhkHTdNh2c9Y6jgeEcs7qWKZguBFyxU+6Uvyc/NCeQ107Xcb2G2OKD0aIf/zIAXNzx0ta2XDSe5ScZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQ7RDlek; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQ7RDlek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3FEC4CEE5;
	Fri, 14 Feb 2025 02:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739499203;
	bh=vqgvcgcjx+dC6CHP2eUMps/+OkBKiiVn+ocDZ7YjXtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQ7RDlekXpARZasSuLbf7/ejboRkRJ2HmnoJY2kJ3WPI9MCHBh1g5igbgcOPGwDvV
	 q6fiB1P7imMLyargedg4+eojXi5+0XSoOIsNFFCAhApoz0ucZGQJJacut3xee52GV6
	 GSP8CQ1Uzc/k4dccLXVemseyLFHRagudQ8cYMsdTilVzomteQBUq1iUm+6zw+j0ooJ
	 boiTO7fpfVY6bm/jpMKSfhINz32JpRFbbMwkHOHMoyDgIQOXhJCCHct8eEMx12INee
	 bFpLXolT4XlR5zUX/oZu4n3RMzHV2ZpAHy+Kr+DDPjUwbNDl+vipjFuTk6nPC10BXy
	 6weIOgtHh6B6w==
Date: Thu, 13 Feb 2025 18:13:20 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
	ashelat@redhat.com, Michael Petlan <mpetlan@redhat.com>
Subject: Re: perf script: perf script hangs forever in linux-next
Message-ID: <Z66mwEOy06-6hvO_@google.com>
References: <c41e4b04-e1fd-45ab-80b0-ec2ac6e94310@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c41e4b04-e1fd-45ab-80b0-ec2ac6e94310@linux.ibm.com>

On Thu, Feb 13, 2025 at 12:06:41PM +0100, Thomas Richter wrote:
> Command 'perf script report flamegraph' hangs for ever as can
> be seen with these commands:
> 
>   # perf record -- dd if=/dev/zero of=/dev/null bs=1M count=10K > /dev/null
>   10240+0 records in
>   10240+0 records out
>   10737418240 bytes (11 GB, 10 GiB) copied, 0.387818 s, 27.7 GB/s
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.074 MB perf.data (1520 samples) ]
>   #
>   # time perf script report flamegraph
>   ^C
> 
>   real  0m53.506s
>   user  0m0.017s
>   sys   0m0.012s
>   #
>   
> Control-C interrupt is needed to terminate the command.
> 
> If I revert commit 23e0a63c6dd3f69cb7ee18411e5f6857cca55b30
>  Author: Anubhav Shelat <ashelat@redhat.com>
>  Date:   Fri Jan 31 09:57:05 2025 -0500
> 
>     perf script: force stdin for flamegraph in live mode
> 
> then everythings works fine again:
> 
>  # PERF_EXEC_PATH=/root/mirror-linux-next/tools/perf ./perf script report flamegraph
>  # dumping data to flamegraph.html
>  # 
> 
> Can you fix this so above invocation works again or revert that patch?

Hmm.. it seems the patch fixes one problem but create another. :(

IIUC the report script should be invoked with "-i -" already, that means
flamegraph-report should see it instead of adding its own.  I think it's
because of the "--" before "$@" so that it cannot pass the input file to
perf script and give it to flamegraph.py instead.

Can you please test if the below fixes the problem both for your use
case and the live mode (perf script flamegraph -a -F 99 sleep 1)?

Thanks,
Namhyung

---8<---
diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
index 83d5738c75ca4726..453a6918afbe8f72 100755
--- a/tools/perf/scripts/python/bin/flamegraph-report
+++ b/tools/perf/scripts/python/bin/flamegraph-report
@@ -1,3 +1,3 @@
 #!/bin/bash
 # description: create flame graphs
-perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -i - -- "$@"
+perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py "$@"
---8<---

