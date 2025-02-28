Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2726FDA6;
	Fri, 28 Feb 2025 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760634; cv=none; b=nQK/B/7gnRvB1rCDTlHIvsL2VvZEYsAmt5aKekTGYXnqc6Z1uuahuoJv1JrnsXn6Eamy/Q19MDY0tHviRu6Z40hpRjB4PLqGRzmCOKbTqGIrQXaV2CW3UxmKsqn/lDGj5DOs9eSG+wFU91M5qTk/dPmf3WlHhWh1nc3fNSAiL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760634; c=relaxed/simple;
	bh=IsrAoHmwRizMrAZgw1O3gBeL1nVVp1ZkGVdtljxvJTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dInZus5sgQLFT8GGewqoZ98wvb800jORxI0NvSmZj+mMTffapvldP5i+FI4ZSZZVi+E5/adX+cxzKROSn1bUycCnKpPC5bK4MXeJ+x/qPdnxk5nrEo07gla4X9A+xiEwqPu7dRCVs/8nKFeYJupFfwKOsgkNt/yEZidk8QVBLJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O0khgrzr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O0khgrzr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SFRSsT026697;
	Fri, 28 Feb 2025 16:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=IsrAoHmwRizMrAZgw1O3gBeL1nVVp1
	ZkGVdtljxvJTI=; b=O0khgrzrVl5nYQhzDgD/c7xgXWKb2/5qxT5D1hlbh6MJ70
	f21rcb9Qb1KYCNEBik2HvA6VBB0qBJwKASBvZyVj/EFdkZ2FIQmx28Eiue8j3KFs
	ZB+r4SAOPe6lh+cQJuy97VQ7dR1nnGvSh2WLzog1PJxVbhXdrIwK5UEKhu+hRKg8
	IxjqTCqpCFcQt7ObU9hNdqK5VqRNEK8H3/SJYFHhf5D7EqHilkwby8vbRyBQpAB/
	QhmJRYoHSW2nJSVP2JXpJ2SdA71CEi4NIFTuTE4g4VGXckEHr5Adbmlz080CCQcS
	GLIcXqdC1cuugdEoT7CE/PzFQroG4mOCOoZ1kvYg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4538uq2m2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 16:37:07 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51SGb7Yc007908;
	Fri, 28 Feb 2025 16:37:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4538uq2m2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 16:37:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51SF3sWX002548;
	Fri, 28 Feb 2025 16:37:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4k751c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 16:37:06 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51SGb4uV31982002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 16:37:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E17520043;
	Fri, 28 Feb 2025 16:37:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E8F920040;
	Fri, 28 Feb 2025 16:37:02 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.39.17.234])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Feb 2025 16:37:02 +0000 (GMT)
Date: Fri, 28 Feb 2025 22:06:57 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 00/10] perf record --off-cpu: Dump off-cpu samples
 directly
Message-ID: <qzkn72zddcdvwst2a4jfeyd3lalfvaydvisx24egxjllvlf2ym@qc5ozzzeqhd4>
References: <20250213230009.1450907-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213230009.1450907-1-howardchu95@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PaUtBPrjR9Uwzi6RwrDp72T6LuSlHgAb
X-Proofpoint-ORIG-GUID: gjKpFC9H8SLI2tVdj1kxRgjceKUniwcF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_04,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=392
 clxscore=1011 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280117

Tested this series on IBM Power machines (both pseries and PowerNV)

Tested-by: Gautam Menghani <gautam@linux.ibm.com>

Thanks,
Gautam
