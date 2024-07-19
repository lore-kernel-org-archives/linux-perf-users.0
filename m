Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CAA145B25;
	Fri, 19 Jul 2024 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398671; cv=none; b=Ql+yQv7gz4Cj4Y9COqSuLA5MZLRYNmNllsulb2NjrB8HgGChcn5GCcwcp4v+vPBv3+BroIn89wt+jV107UUGscoz0OX/382eLBQbcynJ0w4RZDOlmGh54WulsA28vOZmOKdiCudsNaRUO9R+v+/HyBhlFP8xzZOi6yo+4fjk6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398671; c=relaxed/simple;
	bh=fjbah7zJIzQI0vVSMZxYxopIs2C046nYcNKjoqlSBB0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pZyEzGOOHL0n0V40C4rJOGn8A4Wk9JAu5T+hwQwXqRqTlMwnHA0M7z+pe49Pqq6fUDj/R19ajpZYDAq2jdtG7PyBMtZnK4rDSvtHZ/oBy5hmbUksbzhnsWWsKNHGzROqVBzh6wHOKawrZ5A08OhAUrhnj+HpGQaRYOqx2SJn7xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=da0DnHkf; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="da0DnHkf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721398640; x=1722003440; i=markus.elfring@web.de;
	bh=DnJno1zz6dYwMCcnfOctj4gl7uyqZIpfSEdqwRv3a94=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=da0DnHkfp+Rim2Yw108nczJDddGyvMNkkIXLsdbC0UtOVE9WYqs5ezN/YCc1jRMy
	 KPsP74XGmyZddRcYYpOHhKX7uxnl9fWmeR/mM+0kHhOha/2ldmQGYzBApGa6BY7Of
	 GueYrRG41eBMCsJHap19DL4QDmIit1P/KREb6FsBo/11hpsp2mhW4MV2zC/0kF5X+
	 8NwIn3OhHv0arxuFWfk8sD5xOXKb8mHeN09NGpmvodxS1gLxkKyxIX84pPhmmxOBH
	 8UsXBLOHYXn1m8B++dt7GnfTRMwD6bSpeFTl40vJ1kKEexlvNKagJjEsw4xYNPpDK
	 NaSXDPuv8alVMkdlmA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Pda-1sTAX02zLK-00GOsw; Fri, 19
 Jul 2024 16:17:20 +0200
Message-ID: <c564da16-062f-4da6-9021-c68f9c6eab63@web.de>
Date: Fri, 19 Jul 2024 16:17:18 +0200
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
Subject: [PATCH] perf trace: Avoid duplicate code in fprintf_duration()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NtSf3baNegENQrN0LKlhchniiNAgegiI88YnOUaDTukO5KvIfk3
 xBr7eboZ8j70bSwOzSKfqe4jLAfNF9XfYNsQ721iFbGClfsfiz80CIK58QpkdaizlQyD3iU
 OEzMJzH9CYMSzTdfNOHAwPg7FtIfHYbOaidbULooulPKLPmIqrvI3b3lv4zhGWUtkEHlM6W
 YQ8qFHz2xOtryVfrNsI4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2cLl+oXOD3g=;UBjCj0m0gulsCftlKvw8l++5EP9
 8QxixoTpx2v9wifsWOFACdipPf2k+ASUL0Fz1gMaAIuM3cEiIizw8eTgRbBwJWCWeIKqB4KYL
 JyjpqXD0GaOlLhuzNxvERQqNoy+smIQuAbWp1pSOHNHqtFTZTkWcl0er5d+4CAZg75aHpIdU3
 j/SHLPbxTcrMloFu9iBmo7GDiT+p9w+ObRK+2ekJoivTID+WajSbpvCNsHJ0LjWfCEUjlE89q
 U+9rmC7C5ZDTUZKjVDxI5P4iLZkl3Cbzop8KfMA0jBJHzEgepxHBeVO7cqov/qEeg6dLtbwdk
 8WZ9TwKtcJJ/WXbzk3FeGNN/kQn4ukixsAjG2aYDKc9I8JtwYBGC07xTaYcOYJQqGAFT8p3Nj
 F3ypq1y7RF3DNd3928pAQfiSD0P58OQvbbnxbr23QyWBi1yfDjRNk5TuWyaC1b2IvN3Q0Le8n
 xcUkG9skvg3CufDOTJNfGhEZyw80jSNj0cUCCHXBxHjn4g4jKyyEiM2cH2DrBJ+/F/8Bah2uL
 u3cbPjGvG3DxFfJ+GLOSdrGwgPtKBq02exvtUGQvyLBVGcwOEqt4LhzlUSIC+Q8JClUbyjtF4
 7oqAFZG6OWt5YCi08ZtDPV0b/kPY0QDMiEg4cLGRr6po9MdKlpExUriYq/pDbmzsM/hvJczkF
 nHIyGZcLwFwakJir5V9G+leq99LdeOTBJPALsevUCzIipijJ5mrrxxqdO0LPj5vd0NrjRGNph
 JH/haQWdMwkcREAT9thLkJERt9VoUKc0BkGB7uojEJeNvzw3mcpaWX0DYZGgeeB3sdxWslLjg
 sjNC2SpHI/1+Ohwgn9aoaRKw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 19 Jul 2024 16:12:51 +0200

Adjust the colour selection so that a bit of duplicate code can be avoided
in this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 tools/perf/builtin-trace.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8449f2beb54d..e29ae5cb95b0 100644
=2D-- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1258,12 +1258,16 @@ static size_t fprintf_duration(unsigned long t, bo=
ol calculated, FILE *fp)

 	if (!calculated)
 		printed +=3D fprintf(fp, "         ");
-	else if (duration >=3D 1.0)
-		printed +=3D color_fprintf(fp, PERF_COLOR_RED, "%6.3f ms", duration);
-	else if (duration >=3D 0.01)
-		printed +=3D color_fprintf(fp, PERF_COLOR_YELLOW, "%6.3f ms", duration)=
;
 	else
-		printed +=3D color_fprintf(fp, PERF_COLOR_NORMAL, "%6.3f ms", duration)=
;
+		printed +=3D color_fprintf(fp,
+					 (duration >=3D 1.0
+					 ? PERF_COLOR_RED
+					 : (duration >=3D 0.01
+					   ? PERF_COLOR_YELLOW
+					   : PERF_COLOR_NORMAL)),
+					 "%6.3f ms",
+					 duration);
+
 	return printed + fprintf(fp, "): ");
 }

=2D-
2.45.2

