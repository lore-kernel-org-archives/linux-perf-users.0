Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509FC14EC7A;
	Tue, 18 Jun 2024 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700281; cv=none; b=saO2XaxS/BotpdFusVGIWwpN502ID7P8QTlrsR5MKqXTsxQjcmVyuTWLQGH02FLuwJtIB4eUeq+FkkjJMoIBdL13X9XWsmL5oZnfu5Q6Sv0rYEL+T1gFfKslS0eOt0uqkB4ghw1PDmvE2Qald4SFdRBd6tFY+Gv+X4jNDA7KRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700281; c=relaxed/simple;
	bh=6wsrRJKNZP5MFzt9At7Hpo1MMh9ZUz5h5ZdQoHnGy6g=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PqCK69LvL3p6IF4EfJAlyxSk1cet1bNPQicLe2n7FGMIUX7r5a8w03jSbiuJoI19g4fAjMHn3abwMvhgEpZojeTwMX+xfrm/HAhqxiwHj+rmd9XGpBK90FRQfvz2gL3pCn6aDc59dmdXx+CbEp6cJJhkica4LHV72xyWGlI6PYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SIfasgAL; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SIfasgAL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718700280; x=1750236280;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=6wsrRJKNZP5MFzt9At7Hpo1MMh9ZUz5h5ZdQoHnGy6g=;
  b=SIfasgAL70JBoDweG+jB+vYB9JrmnflGMZZC6lQeNA8qtMFFyDlcxfUR
   vnCFqT/Pi6HpLgj94qMMOpR+w4WHLPeED6Jbth8xGeubwgz6EyMNw3aXJ
   lAsG/GGNzF5Fz/y5eRTjiv2Y6d0uCj7idY+tTVx7gOJvZ10sz0dn7d985
   A=;
X-IronPort-AV: E=Sophos;i="6.08,247,1712620800"; 
   d="scan'208";a="97525173"
Subject: Re: [PATCH] perf: Timehist account sch delay for scheduled out running
Thread-Topic: [PATCH] perf: Timehist account sch delay for scheduled out running
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 08:44:36 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:11682]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.205:2525] with esmtp (Farcaster)
 id ef085b91-7167-4b04-9514-55ec948feebd; Tue, 18 Jun 2024 08:44:35 +0000 (UTC)
X-Farcaster-Flow-ID: ef085b91-7167-4b04-9514-55ec948feebd
Received: from EX19D003EUB002.ant.amazon.com (10.252.51.90) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Jun 2024 08:44:35 +0000
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19D003EUB002.ant.amazon.com (10.252.51.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Jun 2024 08:44:34 +0000
Received: from EX19D003EUB001.ant.amazon.com ([fe80::f153:3fae:905b:eb06]) by
 EX19D003EUB001.ant.amazon.com ([fe80::f153:3fae:905b:eb06%3]) with mapi id
 15.02.1258.034; Tue, 18 Jun 2024 08:44:34 +0000
From: "Sieber, Fernand" <sieberf@amazon.com>
To: "20240613185906.31082-1-sieberf@amazon.com"
	<20240613185906.31082-1-sieberf@amazon.com>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>
Thread-Index: AQHavcPKRPBk0WtIL0Om6mdPU7kGjbHJT+uAgAPr3dQ=
Date: Tue, 18 Jun 2024 08:44:34 +0000
Message-ID: <e78393a53b49416088b4d3e849f75686@amazon.com>
References: <20240613185906.31082-1-sieberf@amazon.com>,<1bb99f6f-532f-47cb-963c-c5c0262e383c@linux.ibm.com>
In-Reply-To: <1bb99f6f-532f-47cb-963c-c5c0262e383c@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Maladi,

Ok, thanks for the feedback. I will submit another revision with the update=
d man page then. In my opinion it makes more sense to measure the schedulin=
g delay as the runnable delay (wakeup and pre empted), as we need to consid=
er both cases when benchmarking scheduling policies. However if there is/wa=
s a specific reason to restrict scheduling delay in timehist as the measure=
 of wakeup delay only please let me know.

--Fernand=
