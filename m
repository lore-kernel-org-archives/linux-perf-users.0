Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C1140395;
	Thu, 18 Jul 2024 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309091; cv=none; b=AkoPlSPiNC71XnMnyHlEmKbnwy5Zf31kAiWg4IMVz5bkEXwv5bsuqC8vgKVsNsqlXxgaAJRbk1T2rJ1od0xaIydYF7Wl0PX8xYUNtQVM1Wvfz7VauMFuddG3NLaxO5d9nsFcf5znqbIAcPNgFdGAtXVpPGBZNjBKOIeJrCufpuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309091; c=relaxed/simple;
	bh=IbnjVcjD/gDsPIIINtuZ1kh6E9PTVuBcQTlfUzXrZ/I=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LFPo/ZFYsC9+omn5Ds3mVEKlmIec9YK/zfcl8cs9WGg+VCnzH2YwMt3vArxADxkfFmP2rud0T3iloatKRutbjdc+T6B7Ieq/GJyQ3+2nbCC9r3JHTqyYFD3x0LLExsDA35J/Sw0WrZmvOsfD0051WV8mN/OWQpPzYf5w7razlQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=b5X3+tEh; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="b5X3+tEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721309061; x=1721913861; i=markus.elfring@web.de;
	bh=Oi3RQqwc8YwRoiG7mf8FQel+ZrdjpuN03Bnz/GOyui8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=b5X3+tEhaKDJguRnBm0XXs52WYvJ+ApI++d6yvAlmeq9q8lzMG3OUVTIQIQWru9y
	 /sfLMtYaAKq40vfT4G4Qj/JiEFoBTMm/a+ZD00Ym+62C0Sa8oBtZmQsysigl0+HIs
	 oDyCJOTYRNmbaPlUzcle5lMJyXT9ctpOqFJfS8JWskg/VL5+SVPJIAMH5QnSO9rnS
	 HlSAuxSRtBrXpNDqN/O8SjqGV+xeUZKSK6Yt/VLY802l9PgBeyRyMbBMkYupUg2Zl
	 LHlh9IDA0Ss1ZN0MeyOxxGhnZamyx79E26WVRdgvgJUJAFwBQWp7IMOUqaauOt9vV
	 iWbOcHIdlcOk7MlgPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgSv-1s2I2w04VP-00jdKl; Thu, 18
 Jul 2024 15:24:21 +0200
Message-ID: <c2fcf5b7-217b-4287-94ef-7429fbfe9b53@web.de>
Date: Thu, 18 Jul 2024 15:24:18 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] perf trace: Simplify output of string literals in
 thread__dump_stats()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AVxqHWFZGQuuHQv1K8Q+VDnuWLh48UxOVX8n/sFTmOvDwPKnVQM
 S1hDvwtXluPiejwHJSQnT4cxp7NWzE2N1GjlKSQbjgCNapmr0QYzug5h8+xkFG2HIqUQpAJ
 EE2jExdd0ALdl3b/N/kOC6S7P0T0Xv6q/T5a60WyExRVA/fAZtJIgFjVz25xcCr0xBkURq+
 Ya6HLSDtAkLMEBaf9axiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2UuCpAt+y2k=;Al41A0mGylZRJBqN5wNlUvBQVX0
 Htw3LN+4u7j0gpxwiuw1uI4+DSU4RV0G15u1/5HQGu/8iGaZza56wmE1Mq7yWsBtP0OYsH4sZ
 prMaaHjhjKxI74X5qtOQp8Mtf9kGl/BEgLD5KVAcQpd/aI4XpfzJyMQmTVvcVnb8WXXv9dnjS
 9vWQeDt3BcHP72S+U2l9TaEk6X73dOwKZtsKWJRxbG8HVBma3fDIj8GSllxFCQizgBm5F7boe
 104wc7LT4c6dXdLuvrJmJAvRQgbuLKs9dB8fYZ5VDzp5OWqkS22wZ45LD6i/G/eyr15tLY+t7
 iINkwEZ6D8q0BL3qCuu1MbV4SvA5cF98Yzs7HAiUJlJChNy03pCWtAhk0iQ37PrM9+6eg3DRc
 8jr/TT3pJxU1QiF6FKifNp7W5owWA1cSmpY3MYsmSFDLa268/s4WUOG6jRtmmUNVZ/J1dB4qb
 KOCQ8X0AJ/3K9mSnD6kQbftE1tZEZq8qNoHzQfTcNrREtWsJTyGiEhUjQcYdqVJ96vl/52Fhs
 hmG5WJzOTk6bcNFPfZgjdwLTfRdnCWSsiEp+ZM0vEe+dKfEzT/CahQjR4ncg1tjbDtyjnqdA+
 oezMZMK2L2rk5gB9pfz6lDFbusVctXfatsY49uUE58qlHbGjXosaLYrzDdGytAvFSk8OI3WkM
 OKrXmkRh0H/WSvrK4MbU0+2WkwDCDwaxXFbZ+qfpZon+waU4yKb7MBxbho0CDPCp8l+zk910R
 wHs0WbOpX+vw97+M9SExUJjwxdPElslLzIJ994oCCH4JVWZI6Yhn6VCeVbDyGSd6QiYXtg01s
 1/+0j5R3qFI4+O4s8AJTKc6Q==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 18 Jul 2024 15:12:13 +0200

Combine four fprintf() calls so that the same text is printed
by a single function call.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 tools/perf/builtin-trace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8449f2beb54d..b96fc6c00e26 100644
=2D-- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4238,11 +4238,11 @@ static size_t thread__dump_stats(struct thread_tra=
ce *ttrace,
 	if (syscall_stats =3D=3D NULL)
 		return 0;

-	printed +=3D fprintf(fp, "\n");
-
-	printed +=3D fprintf(fp, "   syscall            calls  errors  total    =
   min       avg       max       stddev\n");
-	printed +=3D fprintf(fp, "                                     (msec)   =
 (msec)    (msec)    (msec)        (%%)\n");
-	printed +=3D fprintf(fp, "   --------------- --------  ------ -------- -=
-------- --------- ---------     ------\n");
+	printed +=3D fprintf(fp,
+			   "\n"
+			   "   syscall            calls  errors  total       min       avg    =
   max       stddev\n"
+			   "                                     (msec)    (msec)    (msec)   =
 (msec)        (%%)\n"
+			   "   --------------- --------  ------ -------- --------- --------- -=
--------     ------\n");

 	resort_rb__for_each_entry(nd, syscall_stats) {
 		struct syscall_stats *stats =3D syscall_stats_entry->stats;
=2D-
2.45.2

