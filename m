Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4153B3C08
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710811; cv=none; b=Tqv38WmnUutkCltgl/hfbYc6xEfTyMO6gQdfx/nkriuPiekHbdvV1ca1KjFkg4ggQ4bjznutHfO41ca8mG5nurCb5sjKo7NYAtq797CjEEvEvhtw9k+/2BAKuqZ2dHguhTGuckYCMADH4kNKtnlaiAJPQpfHxXgjHj6L2eRaQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710811; c=relaxed/simple;
	bh=jnZDT8Sv4Cj1A5f61+G4HgmBdnITr/OETP9KlUhlXV0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kjpf/Tqj3dVl1nFtfsI/SDP2UiUxK3Pue2oBvH2h0ed0jHHzUFLhcVymRaaqSHa8yGPGJ9W28M5NRUjv0kkpIC7QZDdpKAoWrI0K2+u8BeS2aAwcLCWh/axDcc7/QbEHCIcxz60Zj/R2LMkRaCcxiW9FRalQmukTgKf9J5mD5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIBJAwgT; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIBJAwgT"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-86e7f44b773so28831777b3.2
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788710809; x=1789315609; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wSFdM2TEvYurq7tSF4Gk6z6k0v1njEuK783Dp9gtcPA=;
        b=XIBJAwgT2FHv2ReKy2eAFjKpbL+LQ3zJPEtKmwbd3m+eYv1h73S4N/Nti7fm05GGAN
         lUQ3GUTuCHO4qskTUj2+Zgd3vjLL9uMILiOkHUjDqczfxP+cqXBm7Qm41ESqTeG3jeJZ
         d767rVsatbCTnJUoxG374zzjZ0vaNm/AwUmgiuYCUIF7IeZPkAgYi5Y9GysUz3I5v58/
         YGjP3Aur5czFL02Epup7p+UviwlTTXILwk8hSbnKBMC3aPE57KOBn8RzrNgOscbvCr6F
         azo0OtMeWByBY+Y8lUj+SJDBshzjzrufscrneLgx0vsbHr/uxaYAsLscFnxuBel6M1kp
         //Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788710809; x=1789315609;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wSFdM2TEvYurq7tSF4Gk6z6k0v1njEuK783Dp9gtcPA=;
        b=ffl/NSjlOzZTNZFo0+Co8mjct8LJoe9B3UT5eFMfJrdZNlnnn27P9uFYD3mCjgDPHm
         pHk6uRKWeFodmwH50vFyOy+jTxfDo4kCgixp3RQneiwn5NMn+oZlnE9xvuarX2C2ATU6
         DT6UrQO1ggpmjvgSp6m0woZfi2Ef4jmX1mDPRKTrSUAYIZgevcp+GrxbC1N7Vcn81TGe
         O4ebExrPCIJcS7YyqW6vAHppDoCAHcOrfs9I29VSgvvTaxmBLMWmBsKsbWAFjqecU9rA
         gxjywOGz/CwhYT2lAWZ0/WwCmOA9FFdguJ4px6EUn/HrSa92W7+3XdU0WjgP9Duo40SR
         pGDQ==
X-Forwarded-Encrypted: i=1; AKwUvByQ7Ptlm8wGZ6IHWDNtiwpI5pd4mztFoh27paxXet34VKxZYCNS6pEfK18Qh0cF9yJYrgei4JtLhRf5gMm+ck7C@vger.kernel.org
X-Gm-Message-State: AFuF++kXusvSxAKassPwb8lNBFWg9pdLShGc4Bwo6uxMqf9796M2huJ8
	fnKUZczW3aHHEC7AKSHRek1y71vxnlaGH5+COpRBeDoZFnub6wcrxuuH
X-Gm-Gg: AYBFou2MDiQNkiDqSyQSbW5oSsPzr6jAg4yQmf9xaGwKrHID+DcPL4pJMfMSQbG+U1A
	vahcAAX++yP9BCx46t+uajKXuIfP14B/6ciB11ViqIIeQy/l/7EJy2HOG8Fd6sXqoUxs6LARGgR
	pBxB0q55N0YQggKZSVj5oQLn+CPZDyRhIfitvR5z5kMdLH8dbKsw6Ec9Hdizr5lHKtwkDCO2yFC
	Bn3ViJem0QpA5DpkD96uV4fIDVoTyd13lGLXywP7xPmNHGIMG0rdTEkvd4Cx0WGASEl8cWFU9QD
	vzksEmF3Q9OrDUF6k5s6r/AEus4uHQ/9V+BjXtrvlDVSjezPgGjb2iyI4Gxy8JAK61p59hOeUch
	qgyYVm+yW0wc8QO5jup2U8YqA/uWktSlyGGDZLnEenyAsf4r/FSAB54fiyfBB7uP2padM7lnuMo
	N97hfNOfx7DF5uIB88rgXih9j4JgeSI5fhHgv/H82me35iAgR2K+Vb6jfiSSENjA==
X-Received: by 2002:a05:690c:5:b0:873:5ddf:d85c with SMTP id 00721157ae682-8735ddfda02mr35034637b3.39.1788710804269;
        Sun, 06 Sep 2026 09:06:44 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62503dsm57819517b3.38.2026.09.06.09.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 09:06:43 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 0/2] perf tools: port UI from GTK2 to GTK4
Date: Sun, 06 Sep 2026 12:06:41 -0400
Message-Id: <20260906-perf-gtk2-v3-0-e1f2086214a0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMwQ6CMBAFf4Xs2ZqypVU8+R/GQylbaBRKWtJoC
 P9u4eRBj/PyZhaIFBxFuBQLBEouOj9mEIcCTK/HjphrMwNyVLzmik0ULOvmBzIppdG8aholEfJ
 /CmTda2/d7pl7F2cf3ns6ldv6q5JKxtlJqqqxZ4lC19du0O55NH6ArZLwr4nZFGSMtVwK05bf5
 rquH94gwZ/cAAAA
X-Change-ID: 20260906-perf-gtk2-555ca04bb652
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 bpf@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3276; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=jnZDT8Sv4Cj1A5f61+G4HgmBdnITr/OETP9KlUhlXV0=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLm9k86sCNzyf/XgRu3LrN2/vbnzGkXdb/Cb1+SfRKXn
 glYYuu4u+MjC4MYF8NMMUWWuPWKLLPadiz1OS39C2YOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIziIXJ6DBqZxcWlqUW6aQVFDnn5JYklmfl5xXr5Bal5BekFemmZaSUZGflFxalAI/TyUkt
 MXR3djAwNTCwdLcycLBxNTZydnQyd3BwdnV2djCzNTQycLR1NXC3NGbg4BWCu6ZvNyLD+Xk04Y9
 j95hfb7mcw/WdtMvnUcjl3ge4Z4buGHjlnRe4yMkwq4OrNlu8+0m62/FJO6cYlvK1rTR5mKaRcY
 NRtWMOsxAcA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

GTK2 is long dead upstream and increasingly hard to keep building on
current distros. This series ports perf's GTK-based report browser to
GTK4 and fixes it up so it's actually loadable at runtime after the
port.

Patch 1 does the mechanical port (build system, widget API changes).
Patch 2 fixes a runtime issue found after the port that prevented the
browser from loading.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v3:
- Fix GMainLoop leak if perf_gtk__error() is called re-entrantly: track
  active loops in a list instead of a single global pointer
- Add explicit <stdarg.h>/<stdio.h> includes instead of relying on
  transitive inclusion, which musl doesn't guarantee
- Drop the gtk4-infobar feature check and HAVE_GTK_INFO_BAR_SUPPORT:
  GtkInfoBar has been unconditionally available since well before GTK 4,
  and the check was failing outright due to its deprecation warning
- Link to v2: https://lore.kernel.org/r/20260906-perf-gtk2-v2-0-3eccff053cd1@gmail.com

Changes in v2:
- Fix error dialog's nested GMainLoop hanging if the parent window
  closes or a signal arrives while the dialog is open (quit from
  "destroy", not just "response")
- Fix build with GTK_INFO_BAR_SUPPORT: gtk_info_bar_get_content_area()
  is gone in GTK 4, use gtk_info_bar_add_child() instead
- Fix use-after-free in the progress dialog on manual close
- Fix reuse of an exhausted va_list in the vasprintf() failure path
- Link to v1: https://lore.kernel.org/r/20260906-perf-gtk2-v1-0-7564bf8523a9@gmail.com

---
Matt Turner (2):
      tools: port perf ui from GTK 2 to GTK 4
      perf tools: make the GTK4 report browser actually loadable at runtime

 tools/build/Makefile.feature                     |  4 +-
 tools/build/feature/Makefile                     | 10 +--
 tools/build/feature/test-gtk2-infobar.c          | 12 ---
 tools/build/feature/{test-gtk2.c => test-gtk4.c} |  4 +-
 tools/perf/Documentation/perf-report.txt         |  2 +-
 tools/perf/Makefile                              |  2 +-
 tools/perf/Makefile.config                       | 27 +++----
 tools/perf/Makefile.perf                         |  6 +-
 tools/perf/builtin-annotate.c                    |  8 +-
 tools/perf/builtin-report.c                      |  8 +-
 tools/perf/scripts/install-build-deps.sh         |  4 +-
 tools/perf/tests/make                            |  4 +-
 tools/perf/ui/gtk/annotate.c                     | 27 +++----
 tools/perf/ui/gtk/browser.c                      | 56 ++++++++++----
 tools/perf/ui/gtk/gtk.h                          | 13 +---
 tools/perf/ui/gtk/hists.c                        | 33 +++-----
 tools/perf/ui/gtk/progress.c                     | 40 +++++++---
 tools/perf/ui/gtk/setup.c                        |  5 +-
 tools/perf/ui/gtk/util.c                         | 95 ++++++++++++++----------
 tools/perf/ui/setup.c                            |  2 +-
 tools/perf/util/annotate.c                       | 11 +++
 tools/perf/util/annotate.h                       | 12 +--
 22 files changed, 208 insertions(+), 177 deletions(-)
---
base-commit: 9f0346dcbea363787186c94ef94dd01aaa215afa
change-id: 20260906-perf-gtk2-555ca04bb652

Best regards,
-- 
Matt Turner <mattst88@gmail.com>

