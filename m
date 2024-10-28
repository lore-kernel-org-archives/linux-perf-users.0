Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3900C188904;
	Mon, 28 Oct 2024 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151092; cv=none; b=Vrgrbw0+YEE3U1mV020r7c6EfApf0HGfVNbV20GGhn5FHn7UMst/00m9JBGzYFi1qvWHP8cPlLpXhERpXxR5MrifVVPoegKwlOrwI0zZm4St9qFFm9cn8L7vlSmIP67W633VIkOAHBgkS5Kb6CeoOCdxeKDugOydM9DtPCIideQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151092; c=relaxed/simple;
	bh=RGZl223q0rxhIgdtO2rcaea+VddtEmNxD71QsdXH1as=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ak72hGPKaaMWVKRin3H5n0msUwAhf+8kn+B/WCk7FTWgskvXZ8RBKjMQlaiq74WXg5y+lYQiZvauerJ1OpymAFdjtR6/pcbaWqPUG7mxfM6mDnze+hL1Mt4GdFnW3IS4PkStSMg0+TSOYDa3OelneGEMRLghE+JR4wa6s+xobp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhNPEuMx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhNPEuMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432D5C4CEC3;
	Mon, 28 Oct 2024 21:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730151091;
	bh=RGZl223q0rxhIgdtO2rcaea+VddtEmNxD71QsdXH1as=;
	h=Date:From:To:Cc:Subject:From;
	b=FhNPEuMxwNsdOIfY9C0Vi4NkoFQvM5EdBvOEgNpHpwBUG/SDJ0FnOkCXhcJlIsZo7
	 fubBQU0RLZmoiZktqtRaCcB3Y1VKhZ88I68PBAniFSvT1YCUYNAnaNHn0LpI7mktFE
	 uheE0BYlFH5FDGrfX9WKlSs8xPFOmjXV57dzYIFBNPKh8ZECmTzWsUgWlRZHgt7vF9
	 STdp7R9jYaKzNh/kUf+rMHqbQ/HO/aL6/FbLXsORZg/IMDmCXXvQb9IeVDpKzBR0V8
	 szzaCZ1Iiw4tsNR4yoeZkTXkZbnPttNyKuei3K9FneTNmXdeBgfPWO9OgHiPBtIOcN
	 JRw+ubU51ZXMQ==
Date: Mon, 28 Oct 2024 18:31:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	"Frank Ch. Eigler" <fche@redhat.com>,
	Francesco Nigro <fnigro@redhat.com>,
	Aaron Merey <amerey@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 perf-tools-next] perf probe: Fix retrieval of source
 files from a debuginfod server
Message-ID: <ZyACsIFUETsr7-09@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When perf is linked with libdebuginfod:

  root@number:~# ldd ~/bin/perf | grep debuginfod
	libdebuginfod.so.1 => /lib64/libdebuginfod.so.1 (0x00007ff5c3930000)
  root@number:~# perf check feature debuginfod
            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
  root@number:~#

And we don't have a debuginfo package installed for the binary we're
trying to use, vmlinux in this case as we didn't specify any using 'perf
probe -x', it will use the build for the running kernel:

  root@number:~# perf buildid-list -k
  38e927fd7799d50dbc4d99ec5e3f781b6105a6a9
  root@number:~#

And communicate with a debuginfo server, be it configured in a
~/.perfconfig file, excerpt from the 'perf config' man page:

       buildid-cache.*
           buildid-cache.debuginfod=URLs Specify debuginfod URLs to be
	   used when retrieving perf.data binaries, it follows the same
	   syntax as the DEBUGINFOD_URLS variable, like:

               buildid-cache.debuginfod=http://192.168.122.174:8002

Or via the DEBUGINFOD_URLS env var, as distros like fedora do by
default:

  root@number:~# echo $DEBUGINFOD_URLS
  https://debuginfod.fedoraproject.org/
  root@number:~#

To pick and cache just what is needed, instead of requiring the manual
installation of the entire kernel-debuginfo package, which is really
large.

It will, in this example, use the following cache files, deleted
before/after this patch just to test the whole process:

  root@number:~# rm -f /root/.cache/debuginfod_client/38e927fd7799d50dbc4d99ec5e3f781b6105a6a9/source-a1414a5d-#usr#src#debug#kernel-6.11.4#linux-6.11.4-201.fc40.x86_64#net#ipv4#icmp.c
  root@number:~# rm -f /root/.cache/debuginfod_client/38e927fd7799d50dbc4d99ec5e3f781b6105a6a9/debuginfo

Before this patch:

  root@number:~# perf probe -L icmp_rcv
  Failed to find source file path.
    Error: Failed to show lines.
  root@number:~#

This is because 'perf probe' was using just the relative file name, in
this case "net/ipv4/icmp.c", that is where the 'icmp_rcv' function is
located, if we add it and comply with the debuginfo_find_source()
function man page, it contacts the server, finds the necessary files,
cache them locally and all works:

  root@number:~# perf probe -L icmp_rcv | head
  <icmp_rcv@/root/.cache/debuginfod_client/38e927fd7799d50dbc4d99ec5e3f781b6105a6a9/source-a1414a5d-#usr#src#debug#kernel-6.11.4#linux-6.11.4-201.fc40.x86_64#net#ipv4#icmp.c:0>
        0  int icmp_rcv(struct sk_buff *skb)
           {
        2  	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
           	struct rtable *rt = skb_rtable(skb);
           	struct net *net = dev_net(rt->dst.dev);
           	struct icmphdr *icmph;

           	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb)) {
        8  		struct sec_path *sp = skb_sec_path(skb);
  root@number:~#

Cc: Aaron Merey <amerey@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Francesco Nigro <fnigro@redhat.com>
Cc: Frank Ch. Eigler <fche@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 18181017f5fd344e..c2ca94e29aca3849 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1874,7 +1874,11 @@ int find_source_path(const char *raw_path, const char *sbuild_id,
 	const char *prefix = symbol_conf.source_prefix;
 
 	if (sbuild_id && !prefix) {
-		if (!get_source_from_debuginfod(raw_path, sbuild_id, new_path))
+		char prefixed_raw_path[PATH_MAX];
+
+		path__join(prefixed_raw_path, sizeof(prefixed_raw_path), comp_dir, raw_path);
+
+		if (!get_source_from_debuginfod(prefixed_raw_path, sbuild_id, new_path))
 			return 0;
 	}
 
-- 
2.47.0

