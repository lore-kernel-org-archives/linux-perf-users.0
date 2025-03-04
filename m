Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28D742077;
	Tue,  4 Mar 2025 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081857; cv=none; b=WnRTaKdEORq4+Z3j7FDN1QkWwwnwXAdhWuNeNHPNtn00w15mH6gTpXGag1jNbiAs7S3eD8hOHvKzDZHQdDz+wmMACoKWWAnbGkSD6yIPf8E89tgPnR9mKdhNpyHH3zRgYaXYyr5iLi7mNosNPwEPqWL+GCGf02WJUdxQWBKPqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081857; c=relaxed/simple;
	bh=OyViGJ/xSkOScuLl8Kts553uXVJWw4tJ0x/3OkXB+JM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ljUySu8Bz8uycEUdXS7HRQrQgYePSqzXZL910u8ln3lyowj8JX/zUf0AX4CVfRoma7BL0QRcG0ayi3hsxosWaDb/3AtHZ/Y5Sp3l0ZhVJDJwoxBp4YFCyueibHd+zdhxrGN4Th8Nwpp/kaPsQKjOGuhizWX+P36P6vUA8nEsrt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MqkVENF6; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MqkVENF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741081847; x=1741686647; i=markus.elfring@web.de;
	bh=asA99JHuFG45J+PLamKyBXsE7OPnQTEQXbgBwGkvXUY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MqkVENF66K7NM+Rdc1ebVHybRmg/N+adIGafKK9Il2hSAgU2TrzNtZgLEUq+d56c
	 BsdFiDc5Krs3ST5UQtrXMiwTgBMLtxShCEDrcUmVt6nGxd8CNbb+jm8Nk8UBUpb8Y
	 hoJcGToaD0OvNB/d9uXRChUlJoBCIJnqmpO2z12/E7a0MlKgx/TKVovj5hrV2Idrr
	 2h16/SJh8AhNNkmnrenQ2Nythb2jugKPUx+7zEV4TaITCthyCR05xbGKmJyJJGGjL
	 MOAZv2Iwl23em4EP4hIlAM2E4qMXSlPIjIszifMuYP6i/A37+8SZFVVHqTyI6B+Vy
	 DZdJHlDtUnz3USb+lQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.64]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCHy-1tIFxu3iWm-00iB9R; Tue, 04
 Mar 2025 10:50:46 +0100
Message-ID: <c69c79e4-04a3-4182-a694-809a5fa36083@web.de>
Date: Tue, 4 Mar 2025 10:50:35 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RESEND] perf cputopo: Improve exception handling in
 build_cpu_topology()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
 Leo Yan <leo.yan@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <b1c70348-6459-474e-6a0f-d956423368d5@web.de>
Content-Language: en-GB
In-Reply-To: <b1c70348-6459-474e-6a0f-d956423368d5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zwnxKwlzGB6lzUwzmSXhy5SzzNCA5khP3HuvwjAnzkkTSsl+oIG
 DWOKj06jnDp9rAYXsw/PmjRcrC8kxCSzERqmbAssiny6VokvGklOFI3UVmcoUz1bKebDrR6
 jiet48jwrUEis7A8RSdOhtkr8AotZkLyqlfLHfYdYo4FAltrtYdFPdS4GdaLrrLa9Qk+X63
 9qVgzazeoL3JAQOY5jeEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v/LKQqKo3yk=;2xU/kzBRtU5lDFHf7glYk9cze/y
 gg1qF5dIYCm3Nzi0/mGVb3B1sBlZth/yoVVtNWj+M19J/2pqcxNM3esgC+j6y64p/0Q6BE7mt
 2M9Xd/4Tv3rMT5m+r1GfAHh1GP8vsTOIJ9iLRMs1qOhI5edxfAt/hxCyBh9WpkSTbOZv90AB/
 571Q5b9Rcm28BVFAYk7ai6Wg/sTnwACL1Q3mt3/+CToiA0OfI25W4ZKS7PeUumYrJz5KqdUNk
 /9HtLExm8xEz0FwwTmREjksqHGZBetuczVsnHFuDikKLJMYgdmuMm7/aHEd8fY+kQGgsC9Jf+
 0wBabKaYHDnWvBM8cshHa9vJdaFrMg6BLRo/mquLVX35ryWJ8+lccSZ5KwTP0CXytIEIbnE0S
 MylDHM13/8p6gD76hbpaD8bbjEuZrgTHj2Dmbr7biy45PS0D3q1uHpfBSY9o+F7DtNCMYvDvu
 lJIgSn4/J9rTRQbRXeeB+TWtMUryzTLC1rK+Z7A/svKwupl3qPdgKyrBz4cXuz0dYNpOuhr5x
 5YXxuOt/Gfe9ljpUA6OgtLg6gynzkxkIqdLpJeSRhzvSFqEZ/DmMi9MUuVFl7Idtr0zxLvKOy
 bZ3jRPXiPcLdqcX5GBfx9YsuFaD9kqzN3zDHB1UjxifAlDo8qVHtbvhZH6FWmBYuJtK4mbxA4
 R1Cja56gQt07lOGpQXcDGbQMukfnjiLbqYS6+t8bEcOTCajtyvNaNmPmD8KNWpAknbqY83AN6
 6IaRVfdOQV3I0I9/U1iF7mLe7N9N3vLFMv+0H7G/q6Vf/MoPU+PUB2xZ57IcA08TxqO8VIaL3
 HvL3wmzzqg9p4ZNngJu9UdLRqyZXfjb5ESP1R+M6qx/YjcMBdStz615TRQGElDIlDesJO8jKx
 Uh8QLaUBOlPdaSGfG1kwwdy1BdHIznBRD2kFF+Yw9o+dsGKwRshSIBzpYfFXUG4NIXbXlDXHo
 oiksC7f2prXB0VxgoABgjan5P3HhURYUcbsjElfzyGsYPSpw0YlZOr/szVGpLSq1OHMOsWtyO
 yOipxcqzI8ZwzBbM8RQDDG1FFG5PbNKC9lEjzW6MBSX/gww7NgroM7ss+7PVsLyqvO2KdaoHc
 xnKH/WPMGHCrQTCZg4K5r2Ta4h4Ey9jvnOsHfbJX1RbU200YsUvp34y7skAxZrbkSKu+77QjC
 yjqSUwtrjSV0AQu6iP9p9HoGWha4V++3AjN4fKg0rUYpEhtcs3wfAwU/2+wkmJukDxk1/Pxlp
 dQHeBF7phoe/a7HjoxLAo/1Be4ootv7uJ1p3aXxdt/CU5O5pXv1WwKwfUwrjEq0VH3XfitT1p
 Nd5yZAL9nJgMWhsxSbrJHSDOkPA3nPpx6P/kSNtfmxcpt2wLtHieh4oM+whMC16of06gHrJfX
 DIEPVcymD64LXUOe/1xIuQ2EK4+MbJYa357qjo93/YHcGP2koXiyp5/lC1h3J30JEMGHpfx05
 NzvA8yrnqjq8xv9FX1Hh9Kj/scg8=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 23 Mar 2023 22:00:07 +0100

The label =E2=80=9Cdone=E2=80=9D was used to jump to another pointer check=
 despite of
the detail in the implementation of the function =E2=80=9Cbuild_cpu_topolo=
gy=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed call of the function =E2=80=9Cfopen=E2=
=80=9D.

1. Thus use more appropriate labels instead.

2. Reorder jump targets at the end.

3. Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 5135d5efcbb4 ("perf tools: Add cpu_topology object")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 tools/perf/util/cputopo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index e08797c3cdbc..fd185951ee2c 100644
=2D-- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -112,10 +112,10 @@ static int build_cpu_topology(struct cpu_topology *t=
p, int cpu)
 	}
 	fp =3D fopen(filename, "r");
 	if (!fp)
-		goto done;
+		goto exit;

 	if (getline(&buf, &len, fp) <=3D 0)
-		goto done;
+		goto close_file;

 	p =3D strchr(buf, '\n');
 	if (p)
@@ -131,10 +131,10 @@ static int build_cpu_topology(struct cpu_topology *t=
p, int cpu)
 		buf =3D NULL;
 	}
 	ret =3D 0;
-done:
-	if (fp)
-		fclose(fp);
 	free(buf);
+close_file:
+	fclose(fp);
+exit:
 	return ret;
 }

=2D-
2.40.0

