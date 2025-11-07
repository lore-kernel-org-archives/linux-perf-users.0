Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E130F7E0;
	Fri,  7 Nov 2025 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502408; cv=none; b=KtBQrPZLnLF28INQOQslH0yI7i1Bo9oN7tJj1urO6x82QVekWONNz0FN0kA5eS2ez8NMsT4z+XlI6I0iw6z94rYJ4BYKPxzFbCBkK2cO1+GmXz1gjNl7bCTr6UPzyMat0EL5080IRKmtqvUZQDUCPP9JUiokMKJrNldm+mUnQdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502408; c=relaxed/simple;
	bh=6LY9cpZF0ej81jxSfOOkfdTDloE3QZtfZiE2+WUUQXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kIYrPUPSIqy6fXPe8XwKoygoMwhhNTNSU0LWsRVntjOrwOX5xAhF/a6PaOEGvJK+6HzG6mHHUEfZ+q+H3F10s3Du3kQQWdt16JfQjyO/LGnE2MCrwnziaWsvGw69Za+TkxT4Cawcp1mkzI1A8qJUUBUn7CaZgOgM5I6519PyHSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qJTqgt8+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qJTqgt8+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6ISsFo012968;
	Fri, 7 Nov 2025 07:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yvOWkn
	ffWVW7ut0O5keAMv7VSuXUyNFGItujwAD4XSw=; b=qJTqgt8+Wz5zHJIVULffxG
	6FLTy6NLq1h34/NsGmlhVLVhR1xACmWqa0+PthHf/k/ExwSd6xol1EfwEOKJBTXW
	k+SgikTM6CbYdfUzQJBfbOvFEsn4HtEv71XpV1ztSevdaA01JWihYhLp6C+7rPO8
	A1JVYSNJVBVhONOkyYfbhXMMsATUBLJ+yhJCHKS32gKn1kdJE+An6ua83hP8wEan
	H2iJfA4EWS4oF+71V9SyghuvbiNjZH9tP3t4nKrrCDbY+IhsfyUrt216KHJvKPUe
	KSIx9Vlul4UrkNb9BcteoJQ8C5vP7qCpmiuhypL+FcFb8JsfLMFXaHIIO7G55Ddg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vuujn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 07:59:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A77jHGE018659;
	Fri, 7 Nov 2025 07:59:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whnsmqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 07:59:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A77xp2d56361462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Nov 2025 07:59:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F3702004B;
	Fri,  7 Nov 2025 07:59:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0615F20043;
	Fri,  7 Nov 2025 07:59:51 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.111.27.154])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Nov 2025 07:59:50 +0000 (GMT)
Message-ID: <7fa4fcf9db0bd2e1a8d325ffae9c55eeb9ac41ba.camel@linux.ibm.com>
Subject: Re: [PATCH 4/5] perf test java symbol: Fix a false negative in
 symbol regex
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Heiko
 Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>
Date: Fri, 07 Nov 2025 08:59:50 +0100
In-Reply-To: <aQ1UuVQdjZa7HYOF@google.com>
References: <20251105191626.34998-1-iii@linux.ibm.com>
	 <20251105191626.34998-5-iii@linux.ibm.com> <aQ1UuVQdjZa7HYOF@google.com>
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
X-Proofpoint-ORIG-GUID: Kb6pIddpouzfzeZKKgsLyLUsLrsIlfC3
X-Proofpoint-GUID: Kb6pIddpouzfzeZKKgsLyLUsLrsIlfC3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfXxcuHhxaajb7M
 Urnjr7GqsSSjVgZ/aXxqmVhsAqPjpd8kqnZMT3nt2inQteBJBU7yyQq+m9Y76e7SWf+rAo2Jtll
 W87D2dGD9RW5jGKeOnbDAEdMu5VJDT5mDy1oXh5nsB4JWFFatqN+fmIO+zRFw2JMoUOGJGXeSrU
 oACZiJpc3GX2n2JAcc6jjgKxoSINy58BmVfRtTWKw1l1Yz/VYK0HDlyjY8VNqNBBgbCbMtRaYB4
 vmiyQmCnPY3YOgewbx+54gfa+S/2Vrw8Ar5qGgCshRi+ycKD2jIjE+UIk17CXqqcMhg9yb/z5R8
 uipsO4VC1xE5ZcNIDbJUrfIIPdrCboYI43MskBEaXkX6+6UAae356wZlHd9L5GtOwuOz/hVQrLx
 +5FWGWyzpyNAo1f8axhPFiVH2iWlZA==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=690da6fc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=KQ6_QMOoaT4zaDH1_Y0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021

On Thu, 2025-11-06 at 18:08 -0800, Namhyung Kim wrote:
> On Wed, Nov 05, 2025 at 08:10:27PM +0100, Ilya Leoshkevich wrote:
> > There are a lot of symbols like
> > InterpreterRuntime::resolve_get_put()
> > in the perf report output, so the existing regex unfortunately
> > always
> > matches something. Replace it with a more precise one.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0tools/perf/tests/shell/test_java_symbol.sh | 4 +++-
> > =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/perf/tests/shell/test_java_symbol.sh
> > b/tools/perf/tests/shell/test_java_symbol.sh
> > index f36c9321568c5..4c6bc57b87181 100755
> > --- a/tools/perf/tests/shell/test_java_symbol.sh
> > +++ b/tools/perf/tests/shell/test_java_symbol.sh
> > @@ -55,8 +55,10 @@ fi
> > =C2=A0# Below is an example of the instruction samples reporting:
> > =C2=A0#=C2=A0=C2=A0 8.18%=C2=A0 jshell=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 jitted-50116-29.so=C2=A0=C2=A0=C2=A0 [.] Interp=
reter
> > =C2=A0#=C2=A0=C2=A0 0.75%=C2=A0 Thread-1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 jitted-83602-1670.so=C2=A0 [.]
> > jdk.internal.jimage.BasicImageReader.getString(int)
> > +# Look for them, while avoiding false positives from lines like
> > this:
> > +#=C2=A0=C2=A0 0.03%=C2=A0 jshell=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 libjvm.so=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [.]
> > InterpreterRuntime::resolve_get_put(JavaThread*, Bytecodes::Code)
> > =C2=A0perf report --stdio -i "$PERF_INJ_DATA" 2>&1 |
> > -	grep -E " +[0-9]+\.[0-9]+% .*
> > (Interpreter|jdk\.internal).*" >/dev/null 2>&1
> > +	grep ' jshell .* jitted-.*\.so .*
> > \(Interpreter$\|jdk\.internal\)' &>/dev/null
>=20
> Maybe 'jshell' part can go away as well.. but it's up to you. :)
>=20
> Thanks,
> Namhyung

You are right, jdk.internal stuff may appear in Thread-1, as one can
see in the existing example. I will drop jshell from the regex.

[...]
>=20
