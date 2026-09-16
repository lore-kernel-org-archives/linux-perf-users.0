Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF7D3EA947
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789540574; cv=none; b=PiOeug30nPeeSqtplMQhS+Av5ILb48nshCVTY7sjy4irKj6miDJl47BGcESRD/yXSYJA9EcNXgRZtG0cxGTQjp2uTkIsoGMUMAOmCRK7VOEtj/GFg+QjJ8SiXNC/6dnqCpdH8HUKXo5U8pjEb8pLGv1wZIOvQl3KOhaEtkuLSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789540574; c=relaxed/simple;
	bh=kIws7nvp6vwZgmrVaEEGKrpn0ppUWwBDe2sYczlVIBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cZ6Qjf5i/dn2uWjPfwwmgXcaZ8z+dT4RDHJ8y4RQkZsx1GFAFWeqJ+TkYuU+kOkayOAD3GPZSJCWEpK7qP0An0rkwFOJowlUjkcgafgrvCJSapjWzqLPkLVPjC9TYbjN4vk2tqvfexdnRTC/8w0CKv98LGUSDhBey6w40f9dHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LBXBs1+P; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LBXBs1+P"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc42a07d04aso4518448a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 23:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789540572; x=1790145372; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qEsjti7+K6BKEhVBYF1JE/GDiM/SdGujRqb1wVWsRf0=;
        b=LBXBs1+PNsFin+uEbpzd/wgPeSVYOkxMqH5Wb3pByxJAdpcCpWllUKHx1n2xBrkRQ5
         Wzjt3OVCO04ETqxd6tdDKZodCQEKmPsYDe0OtWCGiCKaOVK94Gu2HVjxtps7H1954DDi
         9kPKO5NCksW9Ee9ZdtXoSMlVTeT7dn/VQOBEkBgoiC07ZNVKm/kUV/OitQ4Sc6fusJAh
         jcUxnv6lMiROwTDZXsdjC+iFPLp7Yly34Z/x9Isp+4HhcTgou64yS4HD7dVxINPFjv1r
         bf4c4W0O/khoxFHrMQHnYn4LG9xbWfPcfp0dWBfgSm0v85js3cCsxyhnLrzdYZX9rA1s
         pW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789540572; x=1790145372;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qEsjti7+K6BKEhVBYF1JE/GDiM/SdGujRqb1wVWsRf0=;
        b=qJ4PXp4TvVNZdJ6DRRpYFe3UHl8ME024FR2+hv98LrvKqGM5M44q1zecEssMeNFwDh
         EQlMM9GYvm/4V2J9SNhGQ2BoHKgUbzBR0Fic3cdTimjmNdPIGaLaeZtHBQ7IfzgiuAcQ
         LMktinvMWwSDA2xzNGm8u/vRausugdfNlxI5QQcNm0ve0bDTdztXdIFBdQv3XG+0wr+Z
         eJacMnhpbMuUo2GnkF3oyuz187IK6XpDl2/IBxu3k1Ov3b0/Jvq1XNIEBKiV0fHZmSmk
         KhO/T8assQc9HtiimV4G2PRztJ22BwoxUT+Qt9z2Lw1EJUm+GGiEF99iuPAUXZokxBzf
         BYbg==
X-Forwarded-Encrypted: i=1; AKwUvBwl6kv1btpzYiY9NNnILuM6WE8WDYGSwoJCHBNiobkTIHEfhBPZ+8hhKXDxLAQPofTF/BZCiTbfNaVEXIComVZZ@vger.kernel.org
X-Gm-Message-State: AFuF++mA2cppVgxN56P934vkzqtAVa9njIPjBk14Zq1czbR2F/sSu28y
	W/4/8kbuaHlAFfVVoAS8y1RjdgEA1aQlDAF3y73M0yPPy/M/Ax6fK0kpes1cBJlk68sqrD3G3fR
	pEdOscz140w==
X-Received: from dldyr21-n1.prod.google.com ([2002:a05:701b:4515:10b0:143:8c20:9c79])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d444:b0:39e:b0b:4d1a
 with SMTP id 98e67ed59e1d1-39e1e2e50eamr3922319a91.6.1789540572178; Tue, 15
 Sep 2026 23:36:12 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:35:45 -0700
In-Reply-To: <20260916063545.3103314-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260914170759.1992947-1-irogers@google.com> <20260916063545.3103314-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916063545.3103314-4-irogers@google.com>
Subject: [PATCH v2 3/3] perf libbfd: Report success when an address is found
From: Ian Rogers <irogers@google.com>
To: irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, tmricht@linux.ibm.com
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
index 7a462c9d11b6..edee6752ef47 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -286,6 +286,7 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 		int cnt = 0;
 
 		if (node && inline_list__append_dso_a2l(dso, node, sym)) {
+			inline_node__clear_frames(node);
 			ret = 0;
 			goto out;
 		}
@@ -299,23 +300,32 @@ int libbfd__addr2line(const char *dso_name, u64 addr,
 
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
2.55.0.1032.g73a4cd73de-goog

