Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F02D8375;
	Sun, 28 Sep 2025 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759052714; cv=none; b=u0v7kiCWRuobG4UGIaDdjthxSvJImwhfflAyHnaMsLm0lFLW9MPESm7ymFf1LPxDMvB6YHuun0KooSxQXTsr9EGQrmE6Bdbl58D7iI/g33zF0CBhZXXn+BJXhb6nc2zAaab8ntiAbEQuVWWnP9SIUs4kYgs+2oTClz0c/oHK1Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759052714; c=relaxed/simple;
	bh=TldkllJMw/9XbYAKMbzDqsTTV71qy6xNuGEq1GAVcAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QomMBydOO082b/lYTitNEIUZ3+KrGKJNgp0fPDBswPQSL4v1kBmcd2RTinpJCiPbtBVJUsmMCxF7W/EhkAqaXKlz1YRdZWPML4jkVFjTZM4udoB6EF1jDrgUChyZRGbCFVoGMfcMFjomT5To69ZGkmd1slQzAAWSLVyHe5Jffvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cdb5b1b09c4f11f08b9f7d2eb6caa7cf-20250928
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3a057855-2c0f-46d3-af9b-b675575edb3c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:578ba1d8ad5e3f88e3cb6b41748b55ca,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102,TC:nil,Content:0|50,EDM:-3,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cdb5b1b09c4f11f08b9f7d2eb6caa7cf-20250928
X-User: tanze@kylinos.cn
Received: from [10.42.20.57] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 746815590; Sun, 28 Sep 2025 17:45:01 +0800
Message-ID: <3a7ba221-f284-4fd9-b355-00efb5695960@kylinos.cn>
Date: Sun, 28 Sep 2025 17:44:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/zhaoxin: Fix instructions error by missing
 fixedctr member
To: peterz@infradead.org, kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20250619031947.1111196-1-tanze@kylinos.cn>
Content-Language: en-US
From: tanze <tanze@kylinos.cn>
In-Reply-To: <20250619031947.1111196-1-tanze@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, peter，Kan，

Just a gentle ping on this patch.

Thanks for your time.

--
Best regards,
Ze Tan
