Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F59139566;
	Fri, 20 Jun 2025 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750385473; cv=none; b=fClA2U/vsWaj7zpXrm7FKumc4mjRgkW3HV6hqegd+rbjQ9fOIbpAVFdNTdFdCj6Rno0BNiTPVe7OoCD8FiVm2hHG+tVFkj88u5YDxV5vTUDdn82kJVpmf206bvgToies+nqbL2S94NDz4fQxiYXQTnDQc+YYky8SZssKaDJsLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750385473; c=relaxed/simple;
	bh=WxkctBJ0jCZqdoeGHMGJGwqBrieziUXQFy8IO6qKzRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNa1C3CVrkQv65i8AWF2oiq72uz/IvgJ5auibiOgmX1JWp2SN++YFQYrQQabnswB5UEbgMPL0Q+PVURqUsVToW7QiazjJzHLLAhMebB8kBKhm/JZ/c476VqoM8sHq964Vur68i2gC34QvoI/BMkvuNgzMLuxXM/h/AjPi5iIeXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d10f43b24d7b11f0b29709d653e92f7d-20250620
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:bd91bd8b-fc08-4058-b5c9-5d4a264640f1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:f09a35d0aab9661bfb5527c1412db2d3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d10f43b24d7b11f0b29709d653e92f7d-20250620
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1212513940; Fri, 20 Jun 2025 10:11:03 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id C0FF516001A02;
	Fri, 20 Jun 2025 10:11:02 +0800 (CST)
X-ns-mid: postfix-6854C335-550397538
Received: from localhost.localdomain (unknown [10.42.12.96])
	by node4.com.cn (NSMail) with ESMTPA id 3A50A16001A00;
	Fri, 20 Jun 2025 02:11:01 +0000 (UTC)
From: tanze <tanze@kylinos.cn>
To: peterz@infradead.org,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	tanze <tanze@kylinos.cn>
Subject: [PATCH 0/1] CANCELLED: [PATCH v2] perf/x86/zhaoxin: Fix instructions error by missing fixedctr member
Date: Fri, 20 Jun 2025 10:10:58 +0800
Message-Id: <20250620021058.1421409-1-tanze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a6cd3756-5aa7-435f-9ee7-3fde67c29f17@linux.intel.com>
References: <a6cd3756-5aa7-435f-9ee7-3fde67c29f17@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Please **disregard** my previous patch ([PATCH v2 perf/x86/zhaoxin: Fix i=
nstructions=E2=80=A6]).  I will resend a corrected version asap.

Sorry for the noise.
