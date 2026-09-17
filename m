Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10E40A944
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621509; cv=none; b=Gz9t+/1Cs/9QfPL2hOui7HxXtQ97jWACQM3MwXYHb3qI/TLCZyrhPaKHiOwvoEQ3CYJkY/zhOc6YhGSAEK7Jx7tYuw/Ni8q/oL5AhLPxLfveYRDWxelFsqgCbGscyX17+rdvpCHMPh4gPiGlXNHF9DSBmvma1y15+2gAyJholac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621509; c=relaxed/simple;
	bh=jeEJpcUOnMW1H6iQsMNBSRPc1DiwXIDweaguQDaQWkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uVh0/8oQo1ZXs7GQdp69/AxVmcxBjlTcVouH2QJFLMclSqxvZwF16ged3Rcr7ocY3GHbdtUE/pJjm+pJR8BHT+JpUj9hHP3A95ikAmUzYxdzqc3dkdMIRfHFupyNPypBCuRPP8yoxIz58eMmg9L4nSZTMBgqrZCovZH/dv6adsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V7Qxeuui; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7Qxeuui"
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6c153bab4c3so534132eaf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 22:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789621507; x=1790226307; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Juznuv85kRzuednz/BkmExb07fgMhpHO/r2YE0AU9aA=;
        b=V7QxeuuiFKXpEJvsu5kh1653xt7F88CZu5o4K/5aNYkN5yO/zHaLqd4UkZRV7cARyO
         Cmk1NgwAmRfAcpZllv6/++fbJuk+Sv4WNQTUvqzw9aTJP0/F+XLoYWQu0fNJtL5h60rG
         ZbJZEsJqqI0QoJBXmkFVuYtXAfTfYtOxjoX+zyddFsyFvR8WZqMpd+03kHLzLnifAJKb
         qH6vYziyHOdN1VLxkdoSZ5m7TQINwJbgPbpxY4RRYIFsTBNYlNSJhVxnLlG5l+hovBT/
         kjGlFCH5wYUrku82zriijdVE0mOpPtQSQ2zNiLp9+WADOikQ05zIfp+GMgAfo9PuvTad
         VOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621507; x=1790226307;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Juznuv85kRzuednz/BkmExb07fgMhpHO/r2YE0AU9aA=;
        b=qM+2WScUwKTjoK7Gyu2QrBBmc5vtPEKwcjmFuT3PqFd91R86Y4QnYXhd3BhE244BdT
         Tpg4MGBEjuGf2WDRof9aXcIbfytbTnvGFdbAK04UgcVTqH4OrinHcFD1L1ica4rbbhAS
         B6fn+4QNpp/IFVK4Qwhksq2KWQj3TXjjktMUz13m3fyzK5ZLht9yvcspLnHiphWFJttJ
         wuXUxPnhbeTSOqrOf3OIbTwSDNtms/cz727SvWsqVjaG/8tJAcyWz+wZT9J/szbkEUNz
         NC3AL/xRfp4ry+2hJlyTPg8AHGQWZ7UjCN0yXtJF569Z5WlCoEg4UZaslW2amTyUI3aH
         AMHQ==
X-Forwarded-Encrypted: i=1; AKwUvBycQh3klg/sGZdY05YV5rg9xW7mXph/Ugjc57Mp6SeOf61OPlZNjDKpIcM7lf1ltXf5PxK4eYraXQtmLRlZ8op3@vger.kernel.org
X-Gm-Message-State: AFuF++lO+mrd/EsRs3q1z0vJ4oL+N1yIQZpHfE2p4/ut+N5hIY/+/AT4
	Dcgd9q02dp519xYTbAGUA+35eJW5soGaKQBsNfqVKNQ71JXYGwaGN3f16Y38cLWwgdpJY+1rNzr
	J9v2CBEMQtA==
X-Received: from dled18-n2.prod.google.com ([2002:a05:701b:42d2:20b0:144:bef2:bc76])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:4b82:b0:6b6:71f7:ecac
 with SMTP id 006d021491bc7-6c7d36fa46cmr4661217eaf.32.1789621507002; Wed, 16
 Sep 2026 22:05:07 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:04:50 -0700
In-Reply-To: <20260917050450.703018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916234402.437113-1-irogers@google.com> <20260917050450.703018-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917050450.703018-4-irogers@google.com>
Subject: [PATCH v4 3/3] perf libbfd: Report success when an address is found
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

libbfd__addr2line() only reports success when the caller asked for a file
name. addr2inlines() passes a NULL file as it just wants the inline_node
populating, so libbfd__addr2line() returns 0 for it unless
bfd_find_inliner_info() happened to find an inline frame. addr2line() in
srcline.c treats 0 as a failure and tries the next addr2line
implementation, which appends its own frames to the inline_node libbfd
already appended to. Every frame that isn't inlined is then reported
twice, which happens by default when perf is built with libbfd but
without libdw as the fallback order is then libbfd followed by the
addr2line command:

  $ perf record --call-graph dwarf -- perf test -w inlineloop 1
  $ perf script --fields +srcline
  ...
	    56051a994f8e parent+0x2e (perf)
    inlineloop.c:32
	    56051a99503a inlineloop+0x8a (perf)
    inlineloop.c:47
	    56051a99503a inlineloop+0x8a (perf)
    inlineloop.c:47
	    56051a95841a cmd_test+0xb7a (perf)
    ??:0
	    56051a95841a cmd_test+0xb7a (perf)
    ??:0
  ...

Report success whenever the address is found, like libdw__addr2line()
does, and clear the frames appended so far when appending fails so that a
following implementation starts from an empty node.

Fixes: 257046a36750 ("perf srcline: Fallback between addr2line implementations")
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/util/libbfd.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index d87242d88525..a907d7c1ac94 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -287,6 +287,7 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 		int cnt = 0;
 
 		if (node && inline_list__append_dso_a2l(dso, node, sym)) {
+			inline_node__clear_frames(node);
 			ret = 0;
 			goto out;
 		}
@@ -300,23 +301,32 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 
 			if (node != NULL) {
 				if (inline_list__append_dso_a2l(dso, node, sym)) {
+					inline_node__clear_frames(node);
 					ret = 0;
 					goto out;
 				}
-				// found at least one inline frame
-				ret = 1;
 			}
 		}
 	}
 
 	if (file) {
 		*file = a2l->filename ? strdup(a2l->filename) : NULL;
-		ret = *file ? 1 : 0;
+		if (!*file) {
+			/* Leave ret as 0 so that another addr2line is tried. */
+			goto out;
+		}
 	}
 
 	if (line)
 		*line = a2l->line;
 
+	/*
+	 * The address was found, report success so that the caller doesn't try
+	 * another addr2line implementation that would append the inline frames
+	 * above a second time.
+	 */
+	ret = 1;
+
 out:
 	mutex_unlock(dso__lock(dso));
 	return ret;
-- 
2.55.0.1082.g2b9226bbc0-goog

