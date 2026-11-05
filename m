Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838723;
	b=tlDCmroinQvIsfganrWmy9ND2kJBpLWgy8AUPLDHw1FO3NegRqkCD1PUal6chSSdYSSN
	 DGNbsJWMKlxmMlGMD6sC1enqaXYSZj8lPZ5ZBYMaEuAgbEy4Lhg7pgZYXWwjxKTdKmlP0
	 bQWiLGiGRhaLF8mTG3zPWsnU0EOLphLENbMc/AfMfUhrxBPZlYiIphbn9OP+JvBljH6wa
	 xTsv8jd3nCGz1yd3yCp8VAdgGtdIxFk+wtRiYoY5/OOHInXmlvZM3kV/zGeWNV5sbf3jb
	 /o4Hyq+0agzW4mu9wdPLjfjCFpvoH7Fczf0y1BotUWX0UoRpTzj/pE+svytQdVn8u0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838723;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9QjdMfvLlLiOeQ6G0kRgO30MxEk/1Cr2/haJN/67+Ks=;
	b=UGP3a3rcSJQNUgW1E4im/qYYwkcBfCwh+Insok2LM+R6jfdeTA2RlAYWMjyyyCQU5Xon
	 ZT3Ty0/bsk50TcQ/T6Tdn+REPyK29upEzs94WOO6/HkHg3X1wQ2pbYMU9W1nUPwJxKtz/
	 AP8XJSimRmu4EMUrh1aLwaiUCc6ckSMXCLrdwyqf/LYA7qNOvISceecBoNdyXXEFS5Gn9
	 V/XvwWhOUtQPioFCxfDgRLnANWPSv37hkHelThRMrU/S3yYxLq/d1dVETa9IgSg0MSoq1
	 XM+enp6dnv4pItv/WecKLmw7zNdIQEAPQH1L2VVZ6Mse1CV2R6dG5UvLjl0ZfgLgBuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b="Oo/uU/Km";
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=6dcQwJPH;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1FE606A329;
	Thu,  5 Nov 2026 00:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE1FE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=Oo/uU/Km;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=6dcQwJPH
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1793838691; bh=9QjdMfvLlLiOeQ6G0kRgO30
	MxEk/1Cr2/haJN/67+Ks=; b=Oo/uU/KmQ4qfZolgBEcPDrZ8eOgNSf2QIUXTSl8ac94InI8gDy
	3UYAlpJyCAcguGl+FG82Ik0IsJy5W4ZvQTIs6rv7mGp4SgGdAcPOKAcQ99/J3Ekip8Tc9R+k+vw
	EDQYa676YBMI2aOJS78AYn3gZ6hPDs+E8ukx5M7KlC0qWgXd+IAFv8xEAq1Cq/azOhtcvpUQOu2
	jjpLA6Zjfd3VaTAZkG2GqdJhRjhvBnZhnCzklzPnn87kTkcvexzmAIAsAXws63LmYRFyGxmHcXB
	nZ44KYQOlVh8XsZU/h4u8DTFNCYEeKN3wVSNLrmqijA1v0lB+fSKNNP/rvrwa2GlY9w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1793838691; bh=9QjdMfvLlLiOeQ6G0kRgO30
	MxEk/1Cr2/haJN/67+Ks=; b=6dcQwJPH+Vel4mzfDL72b7VJgtdSJS1llPs3pu2VXFUGGhQvEd
	4zjhV6w50MTVgAzAAtq2sOVaUbdx0TTmWODg==;
From: Bradley Morgan <brads@mainlining.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Bradley Morgan <brads@mainlining.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Wake Liu <wakel@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] two small fixes out of kernel/sys.c
Date: Thu,  5 Nov 2026 00:31:26 +0000
Message-ID: <20261105003129.3130709-1-brads@mainlining.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two unrelated things that came out of reading kernel/sys.c line by line.
They are in one series only because they came from the same read, patch 3
stands on its own and can be taken without the other two.

Patches 1 and 2 have to go in that order.  PR_FUTEX_HASH is the only case
in the prctl switch that does not check the args it does not use, arg5
does not even reach futex_hash_prctl().  Patch 2 adds the checks.  Patch 1
goes first because prctl() is variadic, so the two callers under tools/
leave the args they do not pass as whatever those registers hold, and
patch 2 would fail them at random without it.

Patch 3 is compat_sysinfo().  It scales the 64 bit memory values down so
they fit the 32 bit fields, and stops when the unit reaches PAGE_SIZE.
But do_sysinfo() hands it bytes with mem_unit at 1, so on a box with
enough ram it stops far too early and drops the high bits.  16 TiB reads
back as 0 and 17 TiB reads back as 1 TiB.  The loop only runs longer on
the path that was already wrong, nothing that works today changes.

Tested on ppc64.

Bradley Morgan (3):
  tools: pass the unused prctl() args explicitly for PR_FUTEX_HASH
  futex: reject the unused PR_FUTEX_HASH arguments
  compat: make compat_sysinfo() scale far enough to actually fit

 include/linux/futex.h                         |  6 ++--
 kernel/futex/core.c                           |  7 +++--
 kernel/sys.c                                  | 28 +++++++++----------
 tools/perf/bench/futex.c                      |  4 +--
 .../futex/functional/futex_priv_hash.c        |  4 +--
 5 files changed, 26 insertions(+), 23 deletions(-)

-- 
2.53.0
