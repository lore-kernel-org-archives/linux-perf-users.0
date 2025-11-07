Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9D830E85E;
	Fri,  7 Nov 2025 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502274; cv=none; b=G4yPmHuCT14iW/0gs0imC8vMwdLuq7dDGSwps1IW7YxaFianuqcCzU1dibLC2cGxw8BvCqok6D3r2ZmfwjZxS9qovcq/63PAkm3xIDYh+Dtfh+0g9znggAlkheD43VxnPkQhrUB1W3aSOAk6QGJn1r9jfL19P4YyxOZZyiKjypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502274; c=relaxed/simple;
	bh=cQsDH03FJPYsftVi0oMFM3W6o3R8lR1nwnTNNLCe2TU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KeDwlQjNIupo9AuhTKQCJKraTyMJGhmhIXJMhyC/w1QxJBnXDI8s8zcaJDeffjE4IMUt9WwXWqLx2J5sX416Md8RpdZPjFDbdxIKBhahqdOR+D/0NtgVfhWhA+dcTXhHwY6re0Zo4gxgtgHdlwPTJqDYSU25LSwk2mmxCQWnkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UUT1QBuv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UUT1QBuv"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A769cjm026493;
	Fri, 7 Nov 2025 07:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vssjy2
	U4d/FHNJPciAEURI7aofZSMdGK0FmjHRxEZ2M=; b=UUT1QBuvrBSh+AUk+67AJl
	f2oNAKfGYUPa34gHtA1nahtfFUixVUvFFY7ZWMXCNM0YYaT9fKdbQ2beDUE7Rab5
	ju+7ZG45yfYVHfvgu7Oa2Mtti/BhV43Nz+gspsfvgm2IO8cEykmtB/+3ugfYsUBB
	hQfjtHxZ/Cb0tReWIchEx4lo1sbKR1rrdoR6AlBPogNWzre8k9GsD6zB2Th7HXCF
	WAq0kbDxs7rh1bI4EEPf+C5do5cvO0eIpZNK17Q/BYOy7c5KJac/M9dinZaXhz62
	Wf/+pOBuX+Vhh2WvAETnhWwcDzZMsOL6Z+aaKwqiYv/RejWvgiqGfoOQCSl5ku8A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v2a8dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 07:57:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7476Sj021483;
	Fri, 7 Nov 2025 07:57:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5xrk1f63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 07:57:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A77vcPI16515490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Nov 2025 07:57:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D8A12004B;
	Fri,  7 Nov 2025 07:57:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8E6520043;
	Fri,  7 Nov 2025 07:57:37 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.111.27.154])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Nov 2025 07:57:37 +0000 (GMT)
Message-ID: <2d8e76d7dd3387c2a67e5cf1fa08a2874e910d78.camel@linux.ibm.com>
Subject: Re: [PATCH 2/5] perf test java symbol: Get rid of shellcheck
 warnings
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Heiko
 Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>
Date: Fri, 07 Nov 2025 08:57:37 +0100
In-Reply-To: <aQ1UaEbSM6jmjNEU@google.com>
References: <20251105191626.34998-1-iii@linux.ibm.com>
	 <20251105191626.34998-3-iii@linux.ibm.com> <aQ1UaEbSM6jmjNEU@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xf6PdN9qzUlkdXnXGJsoNOpx70yGiG_U
X-Proofpoint-ORIG-GUID: xf6PdN9qzUlkdXnXGJsoNOpx70yGiG_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX8GXYVA3Ji//C
 xPGteIr5bS3g/CRX4jP1SbL21gazC/3T712/SZ0q/6H0hynPA1WVp+juecJaOCWtkJMUR1acUhm
 mzrWz3EIHgxseCrCoWZ5OXJh/emBzHTuCQQaEHNsWoJOQ/pVf2QLUl6Bva77yBMYU9fl+fMVrOl
 10jwn/ZB/bHASWFbtsUNd38YAi8wE2v+3L3W8xAspUK6W7Bs/wn/BQ/E04PL/77SjW4gDfJNVzW
 3NoLjhV1HzL8664efauCFU592LPVtC+JuyDhilhnZYZRi5/wFLRnlJ+1toa7rOppGUAinOpYPck
 UhDsTno+q/nfKO7SsoA/dwxICyCesy/af/klqJYKO4nzunTCqY8Mxq8ySQc0TR+Sv5dYw61Dwdo
 ihy4cxpecrdBhS1A3ID4WQ0kZTeOPQ==
X-Authority-Analysis: v=2.4 cv=H8HWAuYi c=1 sm=1 tr=0 ts=690da678 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=8BkGDJUJpkJqDCYRLq8A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021

On Thu, 2025-11-06 at 18:07 -0800, Namhyung Kim wrote:
> Hello,
>=20
> On Wed, Nov 05, 2025 at 08:10:25PM +0100, Ilya Leoshkevich wrote:
> > Add missing quotes and suppress the $? warnings.
>=20
> Can you please share the actual shellcheck warnings you see?

There are a lot of them, I have cut similar ones from the output:

linux/tools/perf/tests/shell$ shellcheck -x test_java_symbol.sh

[...]

In test_java_symbol.sh line 19:
        rm -f ${PERF_DATA}
        ^----------------^ SC2317 (info): Command appears to be
unreachable. Check usage (or ignore if invoked indirectly).
              ^----------^ SC2086 (info): Double quote to prevent
globbing and word splitting.

[...]

In test_java_symbol.sh line 54:
if [ $? -ne 0 ]; then
     ^-- SC2181 (style): Check exit code directly with e.g. 'if !
mycmd;', not indirectly with $?.

[...]

> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0tools/perf/tests/shell/test_java_symbol.sh | 20 ++++++++++++-----=
-
> > --
> > =C2=A01 file changed, 12 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/tools/perf/tests/shell/test_java_symbol.sh
> > b/tools/perf/tests/shell/test_java_symbol.sh
> > index 499539d1c4794..b1d7cd43af01a 100755
> > --- a/tools/perf/tests/shell/test_java_symbol.sh
> > +++ b/tools/perf/tests/shell/test_java_symbol.sh
> > @@ -4,6 +4,9 @@
> > =C2=A0# SPDX-License-Identifier: GPL-2.0
> > =C2=A0# Leo Yan <leo.yan@linaro.org>, 2022
> > =C2=A0
> > +# Allow [ $? -ne 0 ], because long commands look ugly in if
> > statements.
> > +# shellcheck disable=3DSC2181
> > +
> > =C2=A0# skip if there's no jshell
> > =C2=A0if ! [ -x "$(command -v jshell)" ]; then
> > =C2=A0	echo "skip: no jshell, install JDK"
> > @@ -13,11 +16,12 @@ fi
> > =C2=A0PERF_DATA=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> > =C2=A0PERF_INJ_DATA=3D$(mktemp /tmp/__perf_test.perf.data.inj.XXXXX)
> > =C2=A0
> > -cleanup_files()
> > -{
> > +# Shellcheck does not understand that this function is used by a
> > trap.
> > +# shellcheck disable=3DSC2317
> > +cleanup_files() {
>=20
> Please minimize unnecessary changes.=C2=A0 It seems you don't need to
> change
> the function declaration.

My bad, I ran shfmt as well and forgot about this. Interestingly
enough, there appears to be no consensus regarding style, but { on
the same line is a bit more popular:

linux/tools/perf/tests/shell$ grep -R '^[a-zA-Z0-9_]*()$' | wc -l
128

linux/tools/perf/tests/shell$ grep -R '^[a-zA-Z0-9_]*() {$' | wc -l
185

[...]
>=20
