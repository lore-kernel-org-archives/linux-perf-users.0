Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794515071;
	b=lFKqYnsSkl9aVlbO3SXNQZgl2SfmOxcqi/qR/aLJgzkOWV1fCg+2EnpK72rnItaVQi8J
	 gkBn/ibaH9mKXGnhC47DntZw6hRygr0GczAsUQcFTFzpKcC0d3zmQwy3Cq5fc8DuN/LtG
	 d3IuewiHaij7MynKPrmjyEpxEDKuq8n+aTY8pNqC09LPZvYekr0BsAEsE1I7HhBjf0LTV
	 9tdkT+9H4up+IMbEcLkGY60zISxFh/dDBopwiadvBJLpts1PacY4m0GKBc51XlYThxDqX
	 2lOdufs0zRjDWYciTjeDRHl+t+4fD4I9mMwzoqjDhTNrtRDquqOWzYt8n6oqXtsPjsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=RUec0WS/TBor2UAgRFZdUcAzXGozxzCjLHhc50K1dqE=;
	b=MtSTb5HME8oLbu5TkmIpStl1hEimIj/yADcUeHFWG+C9SO0f9h2D68IdfS7cIK31MGfQ
	 0OnlWCgQ8HFu6WaAh6RZ3C9x1/OvprqO62qSGfhy8p6Qw4PzzVdEyh3L+P1MNq/gfsPBt
	 klJbvi8ZJjMJW0bwVqWF5h4DKA4lLTPj4xbirrtrV0V8u2m5qpd6Dk/ofFM50gjjar93b
	 TAT7yeZfdNX7/sBbw+kasMIM15O7xSa1Y2ilsHd/zdiiixklnlpW8fRPAcljjxBJqB+zb
	 1rcZtd+tQoj4+3a3rOFr/uNPEhK3hOLiYp/bO0Qi2wSJ7+iSWDqgDsqW7vs72WEGZuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0DbQOVJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E0D606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 20:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62E0D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0DbQOVJ
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso173866a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 12:24:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794515070; cv=none;
        d=google.com; s=arc-20260327;
        b=WfX43xJSt4zCjax3Qr29goRBZr/S4fvhvnGWvIPunUvpI+MKIe+qpwCYrOYRK6FXdK
         h64EnkgARvj2qu6MRfcZ8asil6lVm43vfmDtIo5GLc1CG7u3RhWfJPFgV/uqbl5znYIx
         TBWf9PwCbGfEBW4tupm6ybjrLHQYzIGMskNmrs3a4c129lnkiEc1X91TfPN8LBbL8dUb
         n1rZImqMyVbSlXu7nIIBISvtrUiOL19KMDS0sjekVvGoKUCDa6F2LLJL+Xsw+Q98QamE
         un4CS6KPXUN0plNGjq8iojWBGO/IFaPtDZ8nIzNywogWy9it4V85LpsycszmWc0ps2KC
         mgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RUec0WS/TBor2UAgRFZdUcAzXGozxzCjLHhc50K1dqE=;
        fh=gIcXGLotfzO2ZmnEhSjFNq+ft2UaQ90WGwRr7ybmEa4=;
        b=BH94MWjS/TaHeVu6/NlSD26Wxclj8LukLVOI0ja9D+r+cc7rrash7NLBbUnmb+DMdw
         bMTNynOqR6WimtIVrJGNWOnbcnBGtyhNXl5tGNfDPmBO1eBPvOGuSNW7iVUifC3MxDiB
         tE/av3zWk/L1zpvjmAxFmobQ8RVQsbjysMEZ8pI5v1h+aQ+tOjXqWNoMeuljv+Kmx65B
         Ta5he/DGN6juUGfUCqgNrnle1OxUHaNPjTKLSjbNxEbo6RHC9zW/SKpwr9JEqIqbBbr2
         Db7tz/j5d7OOa32A16j/tKHj0wbOXTOzEEnwJGWed5cfltL6+jzBh73GxQFyQclXbpSy
         BfvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515070; x=1795119870; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUec0WS/TBor2UAgRFZdUcAzXGozxzCjLHhc50K1dqE=;
        b=f0DbQOVJsAGlUCJfIhBVVSf8mIaYOeiZ4hBTWvGwepfrdxVUFJaUmV8eT0BS2p+mcz
         LJ9BvukjOauTz1TnBBiordGk2/0Rsuyh/jwRua2X3D87d9IOVXC2TehsYeeQEfJUdqCT
         BtjTRzKQZKzbyQrGAeNYizr6jjDCh9UCM/bCFBahNA//2R79v7VFApkKZnSq3KzKvZMS
         dQygErHJE0i9Lb0iUbRZsvg1+8rg7ZUAuGyEvn1wqTALuqSXhX9J2vMKcf7zCg+wuV7t
         ja2Y2dIuB+5hVWe9JsE6CrNlNJycojuog/qjZbQ2FSk9TtiyMYzl3FG6nrd2obpzWQE6
         KofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515070; x=1795119870;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUec0WS/TBor2UAgRFZdUcAzXGozxzCjLHhc50K1dqE=;
        b=IwqWBACO2SSGDZelB08pqpFogthPuB4A7WbFfCA0C7uBgomb9GS7OkWzNvbONSL6Ey
         5wiRqjs/C6WxNdScMB5KEf8rV2kOT/dFHwmQkMyGpi7fwaBIlwhul2tFMPd06GmkNvVi
         f3uQgz26ecHKhBEfpt888hAbouK5O0qkfzZqG9xXSSoV7YDQGsl+q6lcTEP2XtuvA7nB
         Wru5+PKbbPeellRQS5Vm0aPITtJOhmEBLiFaBFZR3wDSOxXlTIJWlnHagD8tN0ZWjWwW
         J8AK2M0ICWmHIABg4SCQkCsmSmqkVidtt6KKj1I9H9tbbiRM87J1gix8Cggqx01v+F08
         fj9w==
X-Gm-Message-State: APuU4Z/CQH9Wuo0s5PxRPhYpaSkUD3KgHuKaQaECJxsfH3Ym760wsZRr
	6h5RHyRKgvguinJpfEU7OoZPOfxetr47sdqnYesf0mvyORuKDKe5LNC1ZjNETV7Py74Xx+DxscQ
	TpVOLRqW3hxSZvJta2D/nCYnmr8hDO5rEqQ==
X-Gm-Gg: AYBFou29CJJt9t7wwDK6x3rTlxO9ya6QavhxuFH5UVCnlIVvCjfK86LPg11SvCB1st+
	W279VOLy0K7VZo8mh+buViRfi5UfCG/nI+qsrNqby5Dtb3qCw7KNs6x4pv0n6sFiKz5dRL4c/UX
	y+nn5/raaWoGAA4Kz7pjJguT0IcSRxUTEDAcofElcT4GPszvO+eeUI8MiH45jD3ppuv5R++kdom
	dEkoiuoRF75fLY1z6kw6cB11dwUDgr0Aunp09czTkYn7G+zSKRhkwgE+eSSldsCdi9xuEcUKq+b
	1+Scfj2RaadNUytMGeX1t7328oyJ6zKzNeLJ/Mz/YzYzrvzfjfD69yUFORjyyBGM4sVx2YIMUV1
	kqRfQEQ1/WYiHwrdPs488Szdvo0ubfNHeuEDt3A==
X-Received: by 2002:a17:903:22d1:b0:2d9:216a:cdd3 with SMTP id
 d9443c01a7336-2ee0daa43b9mr4520815ad.18.1794515070407; Thu, 12 Nov 2026
 12:24:30 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 12 Nov 2026 14:24:29 -0600
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?Q?ORTOLA_Rapha=C3=ABl?= <raphael.ortola@gmail.com>
Date: Thu, 12 Nov 2026 14:24:29 -0600
X-Gm-Features: AclHuK9ori9VDWmH9tMW_uCJRCmGZA7QhoDYl6derL7LPeIAqBmvrYiC13L8iZo
Message-ID: <CACzNvX6qkkd-QgJzcQquHS6XiKacMqb85JeLC8LmfLTeWqu4EQ@mail.gmail.com>
Subject: [PATCH RFC] perf docs: build only the declared manual section
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

While building Ubuntu linux 7.3.0-9.9, GNU make 4.4.1 reports that the
perf manual rules do not update their .5 and .7 peer targets. The
implicit multi-target rules promise all three sections for each input,
whereas XMLto and Asciidoctor emit the section declared by that input.

The proposed change uses the existing DOC_MAN1/DOC_MAN5/DOC_MAN7 lists
with static pattern prerequisites and one recipe per backend. The
shared asciidoc.conf prerequisite is moved after those rules so that
$< remains the manual input rather than the configuration file.
USE_ASCIIDOCTOR selects the two alternative backends.

Checks on this downstream source:
- Before: the native XMLto build reports missing .5/.7 peer targets.
- After: all 41 native XMLto manuals build without warnings.
- Additional section 5 and 7 fixture manuals build with XMLto.
- Asciidoctor 2.0.26 with Ruby 3.3.8 generates section 1, 5 and 7
fixture manuals without warnings, using explicit ASCIIDOC_EXTRA
backend flags.

This is an RFC for the documentation rules; it is not a claim of a
completed kernel build or testing on current upstream master. Please
review the proposed fix below.

--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -174,7 +174,6 @@

 html: $(DOC_HTML)

-$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7): asciidoc.conf

 man: man1 man5 man7
 man1: $(DOC_MAN1)
@@ -259,17 +258,26 @@
                     --date=short --no-show-signature $<)))

 ifdef USE_ASCIIDOCTOR
-$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : %.txt
+$(DOC_MAN1): $(OUTPUT)%.1: %.txt
+$(DOC_MAN5): $(OUTPUT)%.5: %.txt
+$(DOC_MAN7): $(OUTPUT)%.7: %.txt
+$(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7):
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b manpage -d manpage \
 		$(ASCIIDOC_EXTRA) -aperf_version=$(PERF_VERSION) \
 		-adocdate=$(PERF_DATE) -o $@+ $< && \
 	mv $@+ $@
-endif
-
-$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : $(OUTPUT)%.xml
+else
+
+$(DOC_MAN1): $(OUTPUT)%.1: $(OUTPUT)%.xml
+$(DOC_MAN5): $(OUTPUT)%.5: $(OUTPUT)%.xml
+$(DOC_MAN7): $(OUTPUT)%.7: $(OUTPUT)%.xml
+$(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7):
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -o $(OUTPUT). -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+endif
+
+$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7): asciidoc.conf

 $(OUTPUT)%.xml : %.txt
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
