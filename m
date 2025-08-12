Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC2311C34;
	Tue, 12 Aug 2025 05:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754976166; cv=none; b=h35Dh09QU30nxwG3oMlELReim6Ivba57JrkfxohnMdpkyECghjQlRb6we9T0ynvePHSrvm0Ji/aXsPe7/k5UbKTNVwthHML8pVRFF2XKi9rPIRSN1pYWKw7nHBJb8BHv2JP65bnpQyspVyYZRxIZv0gbDnG3LX2bhRhIlDpN8+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754976166; c=relaxed/simple;
	bh=xKGtxk14qWbIxBnbnD7lvK6dle3f9/QDyUPqoK06VWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkNRtzmSUEjpO9yznz9TSx3hHt9rriiVIOynIb9f2FBjzTDz+sNntbJ6872H7sANuMS4x5Cy/QPNffW8EDIfP8UVMzRPoXClPyHB0EAqOBXBNbgEla+kd6fItRKVPwO0Qaf5ghOYHoO/a85+5leYTlHlpigJY5kTMPpyIjhbFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OXvC01V1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OXvC01V1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C07u3a004660;
	Tue, 12 Aug 2025 05:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xKGtxk14qWbIxBnbnD7lvK6dle3f9/
	QDyUPqoK06VWc=; b=OXvC01V1wgcAkEwFeDktK/qmKxIDK2dv77roheOf1O5KgS
	QBTu8iEdRL/78+FJ6hQC3ZqxxYMpm1yJpv2cnMc3c7T4eKxaGWHTHcLM6VgRf30e
	LIelJ0B4MOCnnxSMEqBVQW4aKFYxmI7HRX/fuHmCogsyC/cqbvtuaGWTlEmocsTp
	oU9W0r+GJrd+yt2eC/bqqgIKnyXL2yvACPfgiX9MnPDW82l/5n6tDKZt9Ln3bW98
	K1ZbpcANK72ZqwzJqU3DqCQkIpp63++QZurwoLtRw8bXixXWZ/LFT/L5wGbonNK9
	HoFXIvBq8jDyU1t0lTnEYYSAKiQbrR97sqtl3PTQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnvff8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 05:22:29 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57C5LTYV013997;
	Tue, 12 Aug 2025 05:22:28 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnvff4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 05:22:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57C1h7gx017588;
	Tue, 12 Aug 2025 05:22:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3gman-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 05:22:27 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57C5MQwK27918598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 05:22:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F55B2004B;
	Tue, 12 Aug 2025 05:22:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B71B820040;
	Tue, 12 Aug 2025 05:22:23 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.124.216.188])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 12 Aug 2025 05:22:23 +0000 (GMT)
Date: Tue, 12 Aug 2025 10:52:19 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf python: Add an example for sampling
Message-ID: <aJrPixEe8V-oFK_O@li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com>
References: <20250728055937.58531-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728055937.58531-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDA0OCBTYWx0ZWRfX+DH7CG0D2NIG
 jZjplNYinTnZd7wV7j4zOM26wL1YCjt1KIeWZifMxulrUF9hL5cGEHCznd8534t/3HqN0RPNkXU
 GmsdnQjzxr8j9fr0JLPzAG5NUL+Q4xi6F7FJeTKTavB8t0F+p0QiJThyAjotFoK513ibIHaNK3U
 VtDzVcoOsnrQ6jOpsfmI/+WvPTtLcSFo6Kd0lhQYJB4m8yf2Vj0AQD/LSzJPJXO1BREKBzdgps9
 m4eQAyZ/xQr5V9NrhDYAYS6dRvKWnZiVIf5p7R8Glh46llqG5WTxKvZ4G7c5bizL2GEcdwKzrWc
 fFBPtMe1IPgImY45pbGd3lLN3PedWJUcctzHCgOdBpzbFbUu0X7GN+58F2JUCgttdiiGykpyPUz
 riXd8C7jz1n2lY9rVyPZkEAPpTyHgoPVDigcFtAeSVL+7E9gIPmCf4EtweDIRB+hjm406fC8
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689acf95 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=ksViGgUnWK_QOdP0v_MA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: sFETTEih0as8YD_2vJo2jeMLMK5FdFwU
X-Proofpoint-ORIG-GUID: 6p3ttzUjRn_RS9O2GgLzOmpTikUpQ5Vi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=742
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120048

Hello,

Please do review this series and let me know if any changes are needed.

Thanks,
Gautam
