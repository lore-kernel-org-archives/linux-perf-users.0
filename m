Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3005B478E4A
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781201263; cv=fail; b=SDJBElwVJkJroMUtjeXC3SsmfIPkUrUDU3tLrBcom41WSbKH5v013c/8KbQGftJYIoi5G0Wb+4hoSbZ0j9KJzsCfNcODM76DRWwJ0hzjTad+M1MX79MgH+/p3kZCM+PjXWuOBLCO5L/lUqGaAsAe9qnJH7lQFhKOV0poPCLwJhA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781201263; c=relaxed/simple;
	bh=3qyZ6LsXG3SkiIjnWOCv4nM6Nb9v0dj/uIzH//0uu/Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tULmdhxjuqtv6RzHmtyXIPjZYdAzkuUS5iHIaZbEJouVZUlAJcof2r3uHZcxR3RQI5tlVV4BHphoGaVO/4MaBdy1EEd0F+hDjF80WrlJ5IwLi5v+6I3zoDluR9/zaSn0BQ+VQYlsyv4JF2CUyoqC7ElRBvBa0Md1CHN8LBfWPU4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Tzyw8+kE; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Tzyw8+kE; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Tzyw8+kE";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Tzyw8+kE"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=N9KQV/aWg02zV/BXxlA6DtGGax1n9qb/vPihJ6NWAxxoVN7rcWpErC8lZwAYWcwtQh5X1KrG8SGnAetCYIEXGneCy/bM8SpDFbIe65+Jc7IY/X0NdTi+Wc1+VbALJ+B4ml0WeuGns+JUTprvlktbqg6H2gFKrVhjz5sfihmYHDxbCVsyeh39zT0wpaUkKofCvGMwNAc8tbYWUY2R9bFtfOkZ2j624eLI9PCnPyL6FaRVFOEh1xVCc+2yUKEWU1+cGK097FGy0y1P1JPvswG57s63MyeAJts4bETKnrLindu1++J7Qd0LZXrfiSZ7u1sCBW0YGdtXcRZJ9Ga06fS5Hg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPSgDJWgfa7uyEpZHvqn53EDJdvhgRlHf4Br/9dq3Jo=;
 b=pDYsXV/ElvCzua0vfYV3iJTuru+p8KzTIosTVUxbLEQbcSYRE9Rix1LgSSfn1GTH4G/FsNKM5rsjCpEDV0smLf15EAYpyJ0YVhfd1eDtvLr6fozly+Kvw/V0k+WS/x7RdTllAjGKBAMESaAYyzK89cxYRtYUIVa3u1MHqAvbDZrhbJcn43SNNTVupRiU0il34VHtSpDC+gfpfflt1TcjwgZE8GLN9PwZOKPGEQkj1CVtqp64OmotjDd70GOyYTl5Vsm/pua5XIIzIHjSCyIA69PsYTGJqaJI84BZ+Q7QTueez+z2a6VWKDF5RCKdh6dB8dkhdol+NcJQXxBrdVnFKw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPSgDJWgfa7uyEpZHvqn53EDJdvhgRlHf4Br/9dq3Jo=;
 b=Tzyw8+kEg8HbMASAqFtjtoikY7oAPnsRZY6R+Zo2ihmgyy3a/r1l2E3eQMF1PKmASRXwVXVgcR62JSr2FH6V/6E5AnRO59GEJJ/ZzTkN0mJs/vK/ko6d19xLYPApePIFl9y0idpysR6rYc04IxbRW9b6rCVKgD0QghvSYuGVGvk=
Received: from CWLP265CA0408.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b6::21)
 by AS8PR08MB9503.eurprd08.prod.outlook.com (2603:10a6:20b:61d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 18:07:32 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:400:1b6:cafe::45) by CWLP265CA0408.outlook.office365.com
 (2603:10a6:400:1b6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 18:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.1
 via Frontend Transport; Thu, 11 Jun 2026 18:07:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yE3gW3ixiZD+5zF2YNvWM2OtGA14b8xZX8fhdmyMkbAjpRUMCAioLA76PyYTYDBvnDjjRpbkJeVaoH0j7vq7waC05a9ICSt8+IUeqUgbHp/e7WcmIr9wKDnnHDewrM65dmQBREg+1DWdPTuBDNC1Q65FZovrthrSkWFATfkPPnDV28b5w1uXNsVPs1PbT4Md4lz2jvXf5QHsdwAZyWN1TNpJnNuGQ8g+isZ78Zc9xnL1kCawJtF4MpFKYDyEMe3Mh3jfT2qvQhwz1MKqzEdQbO97Ibv+/f9aps8Wd+WqHq05c4Gz9gd7OIUXDBFd4vhPkohC6s+WmPx9tXK51LejGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPSgDJWgfa7uyEpZHvqn53EDJdvhgRlHf4Br/9dq3Jo=;
 b=L+HL/KW28ZNfNVf7q1/+TuXU6+pX0YkePjVUdLt5PRxcuWPDelarNFZyb1j821gr40niTkLXuRGXaK13i7eN/GbboGxlc+OPFG5g/2oJpdi4tQB0WVi5qf4icZJzcERUNbWKw1xiEIQNXUIb1nm+E0Y8xHNV2Dhl9QyYsJop/QOReDhbctJKJS/j7rZaXCeZVm38FAirggH7zBXGbM5iXtsi+BEh1Lg/Os9rOQskjawWZyrrFmP6sUpfh8eIk38Gspbhklvoy2Ga+8AGzVwB75yWrwMLLbZWug8dH5P7y5xVt5E4zEj7uRzt1SQmyGXDtFYGTpOGyKaNDt4vzh807Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPSgDJWgfa7uyEpZHvqn53EDJdvhgRlHf4Br/9dq3Jo=;
 b=Tzyw8+kEg8HbMASAqFtjtoikY7oAPnsRZY6R+Zo2ihmgyy3a/r1l2E3eQMF1PKmASRXwVXVgcR62JSr2FH6V/6E5AnRO59GEJJ/ZzTkN0mJs/vK/ko6d19xLYPApePIFl9y0idpysR6rYc04IxbRW9b6rCVKgD0QghvSYuGVGvk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM8PR08MB5697.eurprd08.prod.outlook.com (2603:10a6:20b:1d7::24)
 by DBBPR08MB6315.eurprd08.prod.outlook.com (2603:10a6:10:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 18:06:29 +0000
Received: from AM8PR08MB5697.eurprd08.prod.outlook.com
 ([fe80::1578:61f0:5e16:68af]) by AM8PR08MB5697.eurprd08.prod.outlook.com
 ([fe80::1578:61f0:5e16:68af%6]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 18:06:29 +0000
Message-ID: <12fffa51-baf8-4366-a551-3e5a3a8fd65f@arm.com>
Date: Thu, 11 Jun 2026 19:06:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/8] perf cs-etm: Flush thread stacks after decoder
 reset
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260611-b4-arm_cs_callchain_support_v1-v8-5-737948584fea@arm.com>
 <20260611150637.846891F00893@smtp.kernel.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20260611150637.846891F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO6P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::17) To AM8PR08MB5697.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d7::24)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM8PR08MB5697:EE_|DBBPR08MB6315:EE_|AM4PEPF00025F9B:EE_|AS8PR08MB9503:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8fa352-05d4-4fd6-50fe-08dec7e44e7d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|4143699003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 9K9jJwhJaufpwk0NOoGVeOsTIyQHrJ539JMsJdow9EJ7Owd0CqRzrmtEaraWev6iQZPTB7hzHjDtJtr0f6kc79UZ/7OCgraCjwhUC0Coh+DD0mqh9BymMjK5ojhlHySsH26id3C5JGsiP1C4MJPnwCWPOBN1UdttENVE+F1EF8aB7WXIAWtAO1Ttl8/EIymCdUBTYKXcElnlaK4kJ6m/pAveuHlE6lj9w65Y6VnyiDm6S6BFbCa6WuPe0ZKsPt09Z1iOsCjJq1QXnfHfwazc8h0damnRTg0hWaYLGiBzNBIKxV5GXlYnu+W0mx1VwEJdJ6vGl0DWmklbXiG2bOrWv8350SEARi6yOsNXABCSqfjmSc7osGOb662P68xPgBbncOskPm19SSlq+CnGCKMb8+FPhb1KkCbzJo5hot/oYbwkecz62+1BBjRbU/brZ+vej7DaKOIhK55sHcewvI5Lnkmly9OAz7Xtp3FImsc1uj48NW9nXTWeMovjcpabWkcSxDRfXHw6xl52/UxQ/O4Th/SrgvvbPHxOfVOXIcAkZ6u6y5uSCCrLZx7Vc+pKugdHlzfyD4mAc7G6rU4cvJt0xw7P3PB8NCtBGpsMJcebPLT/tFAVs2j/ZaFH01GgSRwi3rnJkIMhl498O1C08J70ICOiXql/LVRxgiCRHJY4PC7GKOOVoYtvALY9FbxEU/C+
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR08MB5697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(4143699003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 fqE1AZKoWSgtQ3a248xB9sgdsThLj1j8q5ytZcKTcHXXwySmyCGhptxLmkbXC/eNseh0gL8wXj95v94L219VYT+uzLcqgEoL9vtSVQLwqhPhkQQnQTOcDTwrBn2NMQ5bp7EDaJX/dvv5n8umrf5MZb8uARD88c34HiSL7QaOI2BvSQkJsD45RoxBd9bqX3dI/GxA98pGfV1R9sVxKZJi4LAFw/kfNcpVzJmSuvxfeEtf4UFy+iQ1EB8SzaiDAB7GV7rAUpOKPyFh3AnQtFiE4W/bm10cON3fYAONTtTxK3ICi22aLPXeqnEVAvVceGWJpMsXVPGMKDgPxol+t7ASmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6315
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	db1e985a-3100-4c1b-11c7-08dec7e4295b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|35042699022|1800799024|14060799003|376014|82310400026|36860700016|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	It2x6GTf1u5JWYydr+oCFHYACKOO3+DG+1iBH9V+TJr2W6pntWMLbdpY3Jo15eMCk0aIiZ4gK+ls36foDIDta/VWE/BDwglhpTiWhfDhiszfnPeNLksY09PZcxK4ICEV4pNxPCI7mIjmp5nPtPGQEe5kv/7nRn6zElEjkihPGNBKIHJY1pF6+iIVEIZjnpXMQgaxSv9UEPIM7SFj+db/p97MoC5onhXGS43B/Tmm5trlIuXx9LJLflYllcdvdoxZrSRivSCFiaS52HEoKJW3/kssvDcZzLT67Q4KnOyAdxEK95dMFgPUqNGWu1YB74xnkOLHjgQ5CaS0ROlOTYIcWUUaTXi06+3cpuUWHMYd7ldOWKf04F/cw5BIGBgblI/61asg/QWCjV4RAQ+NRgGUk959fEYDW4uLE3m2ZGCtBPONIh3BxzXUtRI85z4K+GQTP/4VKRvAqwWyRuAwojMbpQVdIJyJ4TeI1dWop7r7jIWSz06F0XaiQxQamTvi9axHfYyUfiTBF8dgzJdsEx3lgk4jnjFBtFYwdM++cpl0AtCtV5pi8jOg8zqlIbTX7KgMXPN6uKwfnZLT87eqaNp1KW/lq+Yc7yzbzoGev6SXpjcBXSBVeDSl5dvOrCp92V3JspwAOdXQxzKKWnELrSWF1IEgY7mCcrN3Qjug+4CTe8MGMPa6mnCFuqCsxmU1Ae8f1sbvlRdgx6WiT9FTB3kONByDo4ABVUmdct/liLGZlko=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(35042699022)(1800799024)(14060799003)(376014)(82310400026)(36860700016)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H7btzKsA+a9+CMrK0Q+1dYPLF5+xe8nVai4u5Te7hUyLVzpT9nXXPq2l69VlFSM86Tfzlcgu2s3G7DYkIrIMG/ZYInBWPxB2VTJSAB7B7LkYf6mV6Ac0VBsyKC9z8cQnI2wmpsghwtrBPaPPkCrpoKTk2HffJoGpo1lCoWUg3ONEam788AAz8WaASm7+gjMdTXXwLOMUo+vwbIE/yGBqJCoKu41+nYlFVG0cfjxgClvp+5Zhg6ZKDw21vHKxXuM/T4IpHTUqTtNB4LjHbFpwh3JDl/XcNY1v0iYqORQDtFmv7n23oTUzKrrm3H38NdT4mRyqkd5WEy9sVcrMAQ23B5LxXB/LcIa9P2GzBZ7Il4BYv1UFfaaQGV6GllYDFUt4jwqcQ3ew33UGB52vJENCHA52oMTvWasjd26k0xqs805E4CHh0j4GHAqTjYT1KE6U
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 18:07:31.6123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8fa352-05d4-4fd6-50fe-08dec7e44e7d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9503

On 6/11/26 16:06, sashiko-bot@kernel.org wrote:

>> +static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
>> +{
>> +    enum cs_etm_pid_fmt pid_fmt =3D cs_etm__get_pid_fmt(etmq);
>> +
>> +    if (!etmq->etm->synth_opts.last_branch)
>> +            return;
>> +
>> +    cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
>> +
>> +    /* Clear the guest stack if virtualization is supported */
>> +    if (pid_fmt =3D=3D CS_ETM_PIDFMT_CTXTID2)
>> +            cs_etm__flush_machine_stack(etmq, DEFAULT_GUEST_KERNEL_ID);
>
> [Severity: Medium]
> Will this leave guest machine thread stacks unflushed if the PID format i=
s
> CS_ETM_PIDFMT_NONE?
>
> When no context IDs are traced, the fallback logic in cs_etm__get_machine=
()
> assigns EL1 traces to the guest machine:
>
> tools/perf/util/cs-etm.c:cs_etm__get_machine() {
>          ...
>          switch (el) {
>          case ocsd_EL1:
>                  return machines__find_guest(&etmq->etm->session->machine=
s,
>                                              DEFAULT_GUEST_KERNEL_ID);
>          ...
> }
>
> Since the flush here is strictly gated on CS_ETM_PIDFMT_CTXTID2, does thi=
s
> skip flushing those threads and leave their original stale call/return
> history unresolved?

I will update code to:

   /* Host only */
   if (pid_fmt =3D=3D CS_ETM_PIDFMT_CTXTID) {
       cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
       return;
   }

   /* Clear the guest stack if virtualization is supported */
   cs_etm__flush_machine_stack(etmq, DEFAULT_GUEST_KERNEL_ID);

Thanks,
Leo
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
