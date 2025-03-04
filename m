Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4951FCFF8;
	Tue,  4 Mar 2025 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090412; cv=none; b=jGstIcfOhhmR3+m7ZOpv+rwSjLX30UL9mTeWFcBYkTzxZ6bW+S861ZDryOABkZ6OGjNeCSzyiRhTAr9+jdPIRvP5Z6Eg/ueg1KM30rrtTqNy1zJHFZui+77NJEztZAIPXcX8xrm8HqfvzZFIkfA0GZZzrFG19idKFt4gjatSr68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090412; c=relaxed/simple;
	bh=7ST/V5T4ufxfAK6zfRrOh7zOoHPojg42a5i8W4jN7d4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GevOanvOmpRauPLpdDL8NnOmrZt2Xo4jMP3fTNAXjOnb8QeHKYEA/eQo4TPtULWWtmh4JYDovHIpZWGMkz+K/UDpKvoyBgQFUk9NcBSG7mOeaRijYtYT3H01cZFk6a0xqkLQ1jAbaLxWcjt4KYIFj1HQJy/751aamooG/JpJjGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=m8DaGVaq; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="m8DaGVaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741090405; x=1741695205; i=markus.elfring@web.de;
	bh=8jLjvIsrxt1ztOb88CQZSdoEqMwJ+liiQTGsFG0knkg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m8DaGVaqUR1LtPhqrf1AwI4q/Paf4BbEkZ/0RJ1p7izz9zjemsm41mUIOFArfEeB
	 dRutbmbaAPP2jbZs+NZ/sTJDfQSmSYb4G3J0KC8m04gDc2BBo+5QtLwjDBMhRSI/w
	 2jhmvzyVA+b7GNTCJQItAdBQJrnAfzcXIraTZd74MQ2OPxk3mgElaP+9SmQXYZ3XT
	 a6QBqEH7xgLk/dsOK7bIyawoVFueN0wJ7U21p/uZcn7g+E77o1JrWrn7hNOTkhMOt
	 Ez2K25lNPZMfRPkvFHEwoahP2iU0iLYDMZPoj/rP81olT1wPknW7AuA0ocOE9I93c
	 UVO/kjqj47ltPe++Ng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.64]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N45xz-1t7TWu2fgX-00tTfp; Tue, 04
 Mar 2025 13:13:25 +0100
Message-ID: <5b73ab68-fab6-417a-a410-69efc1f7b97b@web.de>
Date: Tue, 4 Mar 2025 13:13:20 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-perf-users@vger.kernel.org, Adrian Hunter
 <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Gaosheng Cui <cuigaosheng1@huawei.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, John Garry
 <john.g.garry@oracle.com>, Kajol Jain <kjain@linux.ibm.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Rob Herring <robh@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] perf pmu: Improve exception handling in perf_pmu__lookup()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0OubccCHVQhlmpwYMG5xgA/CpBovpnSMBDhgzGtKvcLodpvCVjd
 VqbpdJSMLP727VOxVDRFqTa7ieI3lWFBqdLirfvGSDsXjpeqeZSzddm+wkoQno+V1oR5Do5
 Bazzdp8/wrunUSWLQzG/tbbr2v47fUW1nEyuVByHstsBDwTmSIKWr9dy/oZUwHx5a6otk3C
 BieYAzx5syD0OIo7dY9gA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wGbjeNQv/YQ=;IGWOgLk/VsQNZnnrc02749sWvfa
 RBmVLo188gAN3iXeOtKsuvoP6j0/VTAsyBYaHEaofzpwMjjRe6pegkMnYVsIs2BM46mCVDQbJ
 XEAqGS1gMhXix76bwPn9FXT+aVDPh3ZJ8SWoyxC/H7CKfd+bu3GREk0HSW4F48G/uh07VBLLN
 6BBp02djnUI5OuNwxP/3LnQzOpNKvjN23l2BDr/ghdXu1WWn/L0fuo9IHUfNvrTuZ1fjlIMnC
 204T1ZC5wJO12AEtH3WSi/Uiclt7VIdKxT2IUryrMdpX3wh9TcSIhbBYBmJVBWvWrmoWez0a+
 0YYMZLprLm53rIChiZE7RpF9qGBh2wfQkWByczIiRpaRd7F4tuM4w3lziTMSv6ubeUXCTSk4v
 9z6Il+n/fZMFBzbfs4PK1ZCRdjoI8Eliv/hfpXVos2lyKf+KeAAEevn7BFrRTDuVXo3CN/YGr
 1djPxLr14h2CToLIUl36W9kKgYtt8575cud/WtYpNFZCV9TTVPnbG1UhZKxHE3n1DaTJ4A0Bs
 f87wUGHYXtkXUAglGXL4H7IqwcCCsxRHpWciQN0WBpVsa6dcl8P4xb7DXgjgEiym7pc4vHAnv
 O5Z5rFDpfEHBRfCVcK/2pEcrUwasMhVhadI8g8wUDQDPE5LNvPeHENfcHIVWIvshJPrIBiL2I
 tDzUl42tsCBVDxq8lkvn6zoGl0Jj1v1c0viAYvKakwhYUQs1i/Nuo6Dr30TIoEn9idN//sTKq
 nBvCIFC6M/viJYz0TbMABFMyR+X88qhtoWTVUWMhhTIQyQ+8l983Ll4IQetzvdcIuJIK8Pw/w
 vu8IV6/NSecArB7d5vtkrGBN+7+qzzWXQHLBbLjlXemnqtE/757bR59p+EfcMZix5Ki5hETr7
 6NJLduv7dw4E4yDUXVZ9xtkCa8szJWqkf/YI8OMOPAY3EaVsuuXGohcTLanr4Fr5QoR8/JdV7
 iUoMJ50D58iupu3qkdJICV0o2JGYb6g9sfOCrae1ieC3qe4ytSPyLO65b8T167oNZHFAo/pcV
 wGE9CsQCXeq2Z+fzLMn/5U3ppBO+8+06oVr2UNkjDcVHAqyjr8HHombdDJT6OUMCY38PiywuM
 IWDLVkj2IP1fETmqr2QN/1k25gA5bQjlMHMkulsc0WKPBP6gzN9WPWpQtXo0MUKlHZdqheS8+
 In27X3uDIIT2qyru+Lg9XIXtoHJBR3Yf6u7qfxkSrv+ZTYuUtt+sDQjiqIAKc21nsi9LNjSQ+
 donvfUyvD2IBBu9sbIWPuAQ7+PL1nLmhUpF82R8OlQcePXxQ6CDj50b4+Zd6UvpaszA1pLMGv
 RiRag6MVOK3ZQZ89fkTKuzPVehk3cwSUQQC4WkIdSplhcQB8Cl8suGC/6WWHRK1Yp7qLuIq4l
 9W0XTjf3DE5D37lTnKRXpwqDGN7wLZvEZNlyb9TpoMbERmcK9jHsELBM7OF4FSgykglErvBjy
 uCLpMZAToikZ4pKccUDE0YCYnlSM=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 4 Mar 2025 12:55:05 +0100

A zfree() call is not helpful after a failed strdup(name) call in
this function implementation.
Thus use an other jump target instead.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 tools/perf/util/pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 57450c73fb63..74eb46390233 100644
=2D-- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1107,7 +1107,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *=
pmus, int dirfd, const char

 	pmu->name =3D strdup(name);
 	if (!pmu->name)
-		goto err;
+		goto free_pmu;

 	/*
 	 * Read type early to fail fast if a lookup name isn't a PMU. Ensure
@@ -1155,6 +1155,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *=
pmus, int dirfd, const char
 	return pmu;
 err:
 	zfree(&pmu->name);
+free_pmu:
 	free(pmu);
 	return NULL;
 }
=2D-
2.48.1

