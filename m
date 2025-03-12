Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED51E86E
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Mar 2025 01:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741742887; cv=none; b=GHeaglpbWgqJBnChNFnAdztm+k5rhHAFtSXKXjkPlE7zVeTYc1enWR7gOj+X7OmF830Wd+aKl/Jmf1k3RZjnTvyuHZPI3T8UiWxSmbJoIUGvUnITHRKlBobe2rZXR4vsVHN2P7SF6luo3tcndOyHTJgM48hMW5HU6KlagntHgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741742887; c=relaxed/simple;
	bh=53tSNIzyv1OxD0bNEkJxfiIn4CkE1M0Ocq1RkJ6bgLI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YjI3Ho5zzQ1fbtfZa0eLvSmW0Tvzen95P0jG39wnAVCwDnoA+CUN9qyXhO6ITghkFvy+JARaGWDF1I12eSUep6NEgxlvIks1HrdmgeS/0Lh8kFV4F4kex5RWs3TIVANkd+cmlWFHJcSHJE4AlzAaa99sY95HK7TaK5QIgrpjP2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Kurmi,
 Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Saarinen, Jani"
	<jani.saarinen@intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlZ3Jlc3Npb24gb24gbGludXgtbmV4dCAobmV4dC0y?=
 =?gb2312?Q?0250304)?=
Thread-Topic: [????] Regression on linux-next (next-20250304)
Thread-Index: AduSrWlShT/u9jWuQGqLTs10S+pbfAAQDApw
Date: Wed, 12 Mar 2025 01:27:30 +0000
Message-ID: <079a4ed4cd724cf28d99f01e1ebd0605@baidu.com>
References: <SJ1PR11MB612942635D5D653CE475A5ABB9D12@SJ1PR11MB6129.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB612942635D5D653CE475A5ABB9D12@SJ1PR11MB6129.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex16_2025-03-12 09:27:31:063
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex10_2025-03-12 09:27:31:217
X-FEAS-Client-IP: 10.127.64.33
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 52:10:53:SYSTEM

PiBIZWxsbyBMaSwNCj4gDQo+IEhvcGUgeW91IGFyZSBkb2luZyB3ZWxsLiBJIGFtIENoYWl0YW55
YSBmcm9tIHRoZSBsaW51eCBncmFwaGljcyB0ZWFtIGluIEludGVsLg0KPiANCj4NCg0KVGhpcyBo
YXMgYmVlbiBmaXhlZCBieQ0KDQpodHRwczovL3dlYi5naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp
bnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQvY29tbWl0Lz9pZD03YTMxMGM2NDRjZjU3MWZiZGIx
ZDQ0N2ExZGMzOWNmMDQ4NjM0NTg5DQoNClRoYW5rcw0KDQotTGkNCg0K
