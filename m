Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D62765C4;
	Thu, 21 May 2026 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374143; cv=none; b=W5AjPU3uww20PfxQq76CINpXK6v9mgcKZWG04b1PuKqaT4SZVsmQ9ea8r3MHyDy9DinDz70QKwRugPxgBe2kNUjpqUauTCi/Q8pGGfB+sNNXnGmhOOZd10G2UjTpjCpRELNqHzkE9/2uL0u1T9swQbxySaVYY7mMwLuMnqos7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374143; c=relaxed/simple;
	bh=JD9wwAqLHNWv1BJTOIGtyvMQswNx54cCBM3ERCaKrX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvHrWtvPO9x7VTlav/4luxRde+wjpenZ7VTogGlzkeOs5ahKSIq6U/9B0boZJZJ18VG+EdYKCGVbJ1vliXiTcvurgPxIAd1IDGW00JE3bvn073O663J+sw+jlWVI7iYmGbG6gA1Pnmoim6bfb/ZMmfZxjUFSef2TRXg1xSBmQO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wIT7Ztpw; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="wIT7Ztpw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=02vHT7moAVtylZdwi9kI/iYvXhHTet1oCy5S6VcaqZg=; b=wIT7Ztpw+h/HQzeatDf0qFZ+0G
	x65sYOIaatCGWb6KBb3xnill3hEB25nDqXkKr/sXhn1h5OlNwvJ8N+oG7sWBN6rm+0vpyfnn23iUB
	86aQzMXT+7KVFpyzuB3kM1RIF2du+AUVBuNhC69ppVtIrKtVmg6O0rO4EpPVCkU2hAsJdBHvrkoSY
	vN8+MbVzvqu9ZOgr3ouUmq56wBdXZJcCo9ov3GlDxca7mKEw6CRjmsUCmFa+ii9gmP1O/arEZT/5v
	vGfAxIFU/SgT8gHEvL7wqyWaiQ7yWQjA4+lOiHFckG78GYbdEE7vib3dtTwcQ3MljfcCUeSva/KP5
	nEDEjIMA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benh@debian.org>)
	id 1wQ4Uh-003x5K-0L;
	Thu, 21 May 2026 14:35:27 +0000
Date: Thu, 21 May 2026 16:35:25 +0200
From: Ben Hutchings <benh@debian.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/3] rtla: Fix output files in source tree
Message-ID: <ag8YLYKZTKOq0t4x@decadent.org.uk>
References: <ag8X7gcDw6jpJsLq@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3il+V813CeHl2qul"
Content-Disposition: inline
In-Reply-To: <ag8X7gcDw6jpJsLq@decadent.org.uk>
X-Debian-User: benh


--3il+V813CeHl2qul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some output files (src/timerlat.bpf.o, src/timerlat.skel.h,
example/timerlat_bpf_action.o, tests/bpf/bpf_action_map.o) are
currently generated in the source tree, preventing a fully out-of-tree
build.  To fix this:

- Add $(OUTPUT) to their filenames in the relevant Makefile rules, and
  create subdirectories as needed
- Add $(OUTPUT)src to the include path
- Add ${OUTPUT} to the BPF object filename in tests/timerlat.t

Fixes: e34293ddcebd ("rtla/timerlat: Add BPF skeleton to collect samples")
Fixes: 0304a3b7ec9a ("rtla/timerlat: Add example for BPF action program")
Fixes: 5525aebd4e0c ("rtla/tests: Test BPF action program")
Signed-off-by: Ben Hutchings <benh@debian.org>
---
 tools/tracing/rtla/Makefile         | 31 ++++++++++++++++++-----------
 tools/tracing/rtla/tests/timerlat.t |  4 ++--
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 45690ee14544..f54da7be735d 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -66,30 +66,37 @@ ifeq ($(config),1)
   include Makefile.config
 endif
=20
+INCLUDES	=3D -I$(OUTPUT)src
+
 CFLAGS		+=3D $(INCLUDES) $(LIB_INCLUDES)
=20
 export CFLAGS OUTPUT srctree
=20
 ifeq ($(BUILD_BPF_SKEL),1)
-src/timerlat.bpf.o: src/timerlat.bpf.c
+$(OUTPUT)src/timerlat.bpf.o: src/timerlat.bpf.c
+	mkdir -p $(@D)
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
=20
-src/timerlat.skel.h: src/timerlat.bpf.o
+$(OUTPUT)src/timerlat.skel.h: $(OUTPUT)src/timerlat.bpf.o
+	mkdir -p $(@D)
 	$(QUIET_GENSKEL)$(SYSTEM_BPFTOOL) gen skeleton $< > $@
=20
-example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
+$(OUTPUT)example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
+	mkdir -p $(@D)
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
=20
-tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
+$(OUTPUT)tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
+	mkdir -p $(@D)
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
 else
-src/timerlat.skel.h:
-	$(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h
+$(OUTPUT)src/timerlat.skel.h:
+	mkdir -p $(@D)
+	$(Q)echo '/* BPF skeleton is disabled */' > $@
=20
-example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
+$(OUTPUT)example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
 	$(Q)echo "BPF skeleton support is disabled, skipping example/timerlat_bpf=
_action.o"
=20
-tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
+$(OUTPUT)tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
 	$(Q)echo "BPF skeleton support is disabled, skipping tests/bpf/bpf_action=
_map.o"
 endif
=20
@@ -103,7 +110,7 @@ static: $(RTLA_IN)
 rtla.%: fixdep FORCE
 	make -f $(srctree)/tools/build/Makefile.build dir=3D. $@
=20
-$(RTLA_IN): fixdep FORCE src/timerlat.skel.h
+$(RTLA_IN): fixdep FORCE $(OUTPUT)src/timerlat.skel.h
 	make $(build)=3Drtla
=20
 clean: doc_clean fixdep-clean
@@ -111,10 +118,10 @@ clean: doc_clean fixdep-clean
 	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d=
' -delete
 	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
 	$(Q)rm -rf feature
-	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat_bpf_act=
ion.o
+	$(Q)rm -f $(OUTPUT)src/timerlat.bpf.o $(OUTPUT)src/timerlat.skel.h $(OUTP=
UT)example/timerlat_bpf_action.o
 	$(Q)rm -f $(UNIT_TESTS)
=20
-check: $(RTLA) tests/bpf/bpf_action_map.o
+check: $(RTLA) $(OUTPUT)tests/bpf/bpf_action_map.o
 	RTLA=3D$(RTLA) BPFTOOL=3D$(SYSTEM_BPFTOOL) prove -o -f -v tests/
-examples: example/timerlat_bpf_action.o
+examples: $(OUTPUT)example/timerlat_bpf_action.o
 .PHONY: FORCE clean check
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests=
/timerlat.t
index fd4935fd7b49..e0f3fc4df655 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -74,12 +74,12 @@ then
 	# Test BPF action program properly in BPF mode
 	[ -z "$BPFTOOL" ] && BPFTOOL=3Dbpftool
 	check "hist with BPF action program (BPF mode)" \
-		"timerlat hist -T 2 --bpf-action tests/bpf/bpf_action_map.o --on-thresho=
ld shell,command=3D'$BPFTOOL map dump name rtla_test_map'" \
+		"timerlat hist -T 2 --bpf-action ${OUTPUT}tests/bpf/bpf_action_map.o --o=
n-threshold shell,command=3D'$BPFTOOL map dump name rtla_test_map'" \
 		2 '"value": 42'
 else
 	# Test BPF action program failure in non-BPF mode
 	check "hist with BPF action program (non-BPF mode)" \
-		"timerlat hist -T 2 --bpf-action tests/bpf/bpf_action_map.o" \
+		"timerlat hist -T 2 --bpf-action ${OUTPUT}tests/bpf/bpf_action_map.o" \
 		1 "BPF actions are not supported in tracefs-only mode"
 fi
 done


--3il+V813CeHl2qul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmoPGC0ACgkQ57/I7JWG
EQn/HA//ap9eF5EzMVnvJtnBDgeafk8sxKRhF0zyowwT2RhfaR52D8CsaJlCwz6Z
REr7RW/dN7KwU1X8bsON+0XOWU+FOuio0yBkf5ifyukPF2oTWvP2uIzM+wpn54YA
Exd6D9gMEQzLYwURIRfHcIscCNfK83gQWLZmP2ydRes4GZmHescFzo78SjBKbAPp
UzUS7SbtBz0/6etkGNBvKIqMNVFBXl/dIwcY5Ii2cnpUa3ypPxqxJgbA8WRvoPVm
pM2rfN3/dgBtPipaY0UJS9fnCTNp3NvW+bnji1bkfG3vuj+z7OXqcsTPJuUC5Xfo
4LbzCo//RrJDkmArspgDAbQAHntAlAS5vVV86YsdWFnpa2FQuF5y4IIJSslWQgd6
+Ya2ylNncz8MT4Y9sPZMqUNpHhxkND4nYwqOfI7TPnF1AGVNxtlbauprGcuAmjen
gboeVUEHPKl8IX3WE7wiAKZXIn513J/ONmrrffcz33S3RmVy8RHUZVTp97DVeqRW
PhvcZliP8HjtFtRobvRcbMHSuVR/nZ0rcl2PT3fyP37MUajeMloozUrjUO+kYVnn
fpyMmGpwsb2qNAyd7INyTxoNB7Dky+jacYv1ikwk0dtbvA8dCFAGNKB3EtF5kQFg
iVe9ORwt4XYBlxzKxQTJ3lXCOdRGKWQ+XG/RiT9jQR6YVsepNwY=
=2o3v
-----END PGP SIGNATURE-----

--3il+V813CeHl2qul--
