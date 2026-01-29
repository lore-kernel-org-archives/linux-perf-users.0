Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F92472A2
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 00:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647363; cv=none; b=GsVnzu2aGzcKy/WsJTZSYJTcY88lGiIwpXg2JTiKEtfxZNTVC6PwuZRS6NTj9fasJnXAyroDjTEhJFMLI1kW3l4ki5ZQGTLWRfYA1sBgwnSEDh8SuRK+yQofageYP1zx/9kuu5M0Yi7WimrS1TfeATYVN3cTTb2OHzxq8ZI99pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647363; c=relaxed/simple;
	bh=QxfqLmHwy166Y55kPd89pD+vOqDX4or1HidWnexD+9k=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hRaXK3GUrDMWORoBlSwMcHKKp8mVz5Ed6zjr3N96BJENaOcrRWhIQx2TgnkuxXa2kSjWeTQ57YBJxc4M4Q55EQK+1J+dcIk3o/x58v89Df0lVsDvXCsCUe8rEXpyvGYMeWRdzDf+cOd0S1T1np2y0sdml/zFbcQxVUWD2SzxhT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bDUERcAQ; arc=none smtp.client-ip=109.224.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bDUERcAQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=woagusryhretfguybrxssnov7q.protonmail; t=1769647352; x=1769906552;
	bh=Lg3lj3uGNwWa8cfLr6yePQD8sO+Z5xWVi6WopoLlNTY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bDUERcAQZaQjThu1z7/DvxXFn0RlBP9+++EYc3lwj2JIKDEyz0UymBaWFSbh1Py6+
	 4bgjKj7BskPJBOp3Ycud9SBZgVbPRcxc9fLTPiBeDSe5IhETsizcLMfWsx8lR2o7PE
	 mRxkCUWxZJWOsqewdQ7txIBYrhoAcFX9/zSZmrLsH8cZ64jrqdxzDrBMG8phNJoI1c
	 L5QYMHK2/RTBAMoqpVi2LeR4j8j1BrQHiYmBnMN1WDOv13S+d/JOnzUq/aRihtkYbh
	 1XHMHceZbsXsWWGiSolvgSVphw1MF2RDiVCIHgPNVWmukPMAody1brIBu7MuFGp2NM
	 7IW55jcZr1xVw==
Date: Thu, 29 Jan 2026 00:42:27 +0000
To: peterz@infradead.org
From: Ricky Ringler <ricky.ringler@proton.me>
Cc: namhyung@kernel.org, mingo@redhat.com, acme@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Ricky Ringler <ricky.ringler@proton.me>
Subject: [PATCH] perf utilities: Replace static cacheline size with sysconf cacheline size
Message-ID: <20260129004223.26799-1-ricky.ringler@proton.me>
Feedback-ID: 171348601:user:proton
X-Pm-Message-ID: a641278577c516cda8fac7d498fac42baac73e81
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Testing:
- Built perf
- Executed perf mem record and report

Tested-by: Ricky Ringler <ricky.ringler@proton.me>

Signed-off-by: Ricky Ringler <ricky.ringler@proton.me>
---
 tools/perf/util/sort.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f3a565b0e230..aa79eb6476dd 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2474,8 +2474,7 @@ struct sort_entry sort_type_offset =3D {
=20
 /* --sort typecln */
=20
-/* TODO: use actual value in the system */
-#define TYPE_CACHELINE_SIZE  64
+#define DEFAULT_CACHELINE_SIZE 64
=20
 static int64_t
 sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
@@ -2484,6 +2483,10 @@ sort__typecln_sort(struct hist_entry *left, struct h=
ist_entry *right)
 =09struct annotated_data_type *right_type =3D right->mem_type;
 =09int64_t left_cln, right_cln;
 =09int64_t ret;
+=09int cln_size =3D cacheline_size();
+
+=09if (cln_size =3D=3D 0)
+=09=09cln_size =3D DEFAULT_CACHELINE_SIZE;
=20
 =09if (!left_type) {
 =09=09sort__type_init(left);
@@ -2499,8 +2502,8 @@ sort__typecln_sort(struct hist_entry *left, struct hi=
st_entry *right)
 =09if (ret)
 =09=09return ret;
=20
-=09left_cln =3D left->mem_type_off / TYPE_CACHELINE_SIZE;
-=09right_cln =3D right->mem_type_off / TYPE_CACHELINE_SIZE;
+=09left_cln =3D left->mem_type_off / cln_size;
+=09right_cln =3D right->mem_type_off / cln_size;
 =09return left_cln - right_cln;
 }
=20
@@ -2508,9 +2511,13 @@ static int hist_entry__typecln_snprintf(struct hist_=
entry *he, char *bf,
 =09=09=09=09     size_t size, unsigned int width __maybe_unused)
 {
 =09struct annotated_data_type *he_type =3D he->mem_type;
+=09int cln_size =3D cacheline_size();
+
+=09if (cln_size =3D=3D 0)
+=09=09cln_size =3D DEFAULT_CACHELINE_SIZE;
=20
 =09return repsep_snprintf(bf, size, "%s: cache-line %d", he_type->self.typ=
e_name,
-=09=09=09       he->mem_type_off / TYPE_CACHELINE_SIZE);
+=09=09=09       he->mem_type_off / cln_size);
 }
=20
 struct sort_entry sort_type_cacheline =3D {
--=20
2.52.0


