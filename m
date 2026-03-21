Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C82DCF46
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774125730; cv=none; b=s9VkuTf6fnCB0b4Uqfed3adh3MZhFBynYip6dbiMt88PseLE1ubON1u/syX0k2MC9G1D12YReDC5JO7jDhRfAf/AxmJk57Juokx0J8WDI7ysWYyHfcfglUNmr85zq9qykxqfDiXuh+4JRkOEC/y+m/h34LutWvzwAS2FdFBPSmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774125730; c=relaxed/simple;
	bh=OZ0vhkXcESWaXlMFXjP4BGNct8iBYgWofxs1xvphzlg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HytkqH3FQ4eiviD44qd4H1NGrbJ8s9hxribaEotxZX6pR9yuoAbcYwvAQN0Mp36dcANEz/mi/cVVd3rw4fxdG6dRwX5ribNUBTyjQv5vu3nfczEVIdKHISC6H6AGXd//FI6lz7Ng5mZ5DPFi1C4qvL0Mmzjmkl9LBLfQbh27V8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OjxNZTNB; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OjxNZTNB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1774125721; x=1774384921;
	bh=Ke2uly3CsHt/RmfSFsTRHn/NTy3Zx3KoDqFMpc6RCGk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OjxNZTNB0S24AQAVIKwZfTCcMD0n59RQ93yzEEwiAb+YPZzZDr65RB1dHWtYDOjiZ
	 I/aVSSt9jxlHqexQ1j/PlezWlpoJ/Y4oLKn+BFRyr0O7hy64kuwly9agHUoyPeuKWG
	 r1Ozw/JLHWIrUMJxwy4O5THNOSy+5YQU42B/aSDWzMCFq9FpqzbBU4rjK9m9VqtE+c
	 PWthFNCwFzO+U2KZJZWnr+432w26c4XokQjo5P7jrYyU34yvOaaCi8HS/Bydhgs3AN
	 dR64M4TY0nuDvfRULyvq5oVYSoyjRvtfFMJvpzqxt+Yc1LbiVuPzN83VweN+iXg4aY
	 K4sjYZLc3TdlQ==
Date: Sat, 21 Mar 2026 20:41:55 +0000
To: irogers@google.com
From: Ricky Ringler <ricky.ringler@proton.me>
Cc: namhyung@kernel.org, mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ricky Ringler <ricky.ringler@proton.me>
Subject: [PATCH v4] perf utilities: cln_size header
Message-ID: <20260321204145.26359-1-ricky.ringler@proton.me>
In-Reply-To: <CAP-5=fVk22oOxLSN-2_MioJ3RKUpQwD2TWK9sA=WcegUc_dj1w@mail.gmail.com>
References: <20260214040659.168769-2-ricky.ringler@proton.me> <aaeKBOolC3AyHAFa@google.com> <20260305235655.40779-1-ricky.ringler@proton.me> <THyJLu3kRy_7q7V6-XpKu2hIZsSzkadNwnZ6YIOUSSTS2if2u3OWv6ROm_MtvBWVQVOJ03FVWw0POxzhU0LpeSBhoKSxTwKVV-JhZFJNCvg=@proton.me> <20260308172037.123654-1-ricky.ringler@proton.me> <CAP-5=fVk22oOxLSN-2_MioJ3RKUpQwD2TWK9sA=WcegUc_dj1w@mail.gmail.com>
Feedback-ID: 171348601:user:proton
X-Pm-Message-ID: 0ed19f67388df8c80fbf6644b63e166ebd9fc15b
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Store cacheline size during perf record in header, so
that cacheline size can be used for other features, like
sort.

V4: Ian feedback
V3: Rebase off perf-tools-next round two
V2: Rebase off perf-tools-next

Follow-up patch from message ID "aYZiQk6Uftzlb_JV@x1"

Testing:
- Built perf
- Ran record + report with feat enabled
- Ran record + report with feat disabled

Tested-by: Ricky Ringler <ricky.ringler@proton.me>
Signed-off-by: Ricky Ringler <ricky.ringler@proton.me>
---
 tools/perf/builtin-inject.c |  2 +-
 tools/perf/util/header.c    | 11 ++++++++---
 tools/perf/util/sort.c      |  8 ++++++--
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 2675d32f88cf..11ac7c8c4be3 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2134,7 +2134,7 @@ static bool keep_feat(struct perf_inject *inject, int=
 feat)
 =09case HEADER_HYBRID_TOPOLOGY:
 =09case HEADER_PMU_CAPS:
 =09case HEADER_CPU_DOMAIN_INFO:
-=09case HEADER_CLNq_SIZE:
+=09case HEADER_CLN_SIZE:
 =09=09return true;
 =09/* Information that can be updated */
 =09case HEADER_BUILD_ID:
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4f65faafe75d..2d39da470267 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1310,8 +1310,13 @@ static int write_cln_size(struct feat_fd *ff,
 {
 =09int cln_size =3D cacheline_size();
=20
-=09if (!cln_size)
-=09=09cln_size =3D 0;
+
+=09if (!cln_size) {
+=09=09int default_cacheline_size =3D 64;
+
+=09=09cln_size =3D default_cacheline_size;
+=09}
+
 =09ff->ph->env.cln_size =3D cln_size;
=20
 =09return do_write(ff, &cln_size, sizeof(cln_size));
@@ -2274,7 +2279,7 @@ static void print_cache(struct feat_fd *ff, FILE *fp =
__maybe_unused)
 =09}
 }
=20
-static void print_cln_size(struct feat_fd *ff, FILE *fp __maybe_unused)
+static void print_cln_size(struct feat_fd *ff, FILE *fp)
 {
 =09fprintf(fp, "# cacheline size: %u\n", ff->ph->env.cln_size);
 }
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 13287ade784e..5f617cf03d5d 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2483,8 +2483,12 @@ hist_entry__cln_size(struct hist_entry *he)
 =09if (he && he->hists) {
 =09=09struct evsel *evsel =3D hists_to_evsel(he->hists);
=20
-=09=09if (evsel && evsel->evlist->session && evsel->evlist->session)
-=09=09=09ret =3D evsel->evlist->session->header.env.cln_size;
+
+=09=09if (evsel) {
+=09=09=09struct perf_session *session =3D evsel__session(evsel);
+
+=09=09=09ret =3D session->header.env.cln_size;
+=09=09}
 =09}
=20
 =09if (!ret || ret < 1) {
--=20
2.53.0


