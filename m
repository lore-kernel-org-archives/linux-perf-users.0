Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E43EB7FA;
	Tue, 17 Mar 2026 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760241; cv=fail; b=MiJv2fjkybKqGjrzxe8b/+koFwYIN4N8eZyIMw7fOVW4XpZyB7ew87cSTC3iVzMQParMaXknBcYzqbV/HXXmJ/lqYnjEEkkQm7sS2oJ4RyyI4Z7Luvemfd6D1Nb88Yvjad/W9VRuWhYBSN6ySFu1801dIY62WU29Ms6+dRbfdls=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760241; c=relaxed/simple;
	bh=vz9oDIAvzvJ7OjF4ranK7Xou3XmDOYtKYKg8rNW6xHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wv++mkvneNruTuuKM7tUQ8AZBkJiLCNgXppja3YYITOpHNivfz6B4GQS1FPVqzgSULAlDH8W24yJfV2UCwMLE42v8pn5t6rFEqdvn+PJxjIivUDqc9RlcacXgvaG43R1eXp+aZD+AsJEZn+o8zBw/bGdbr9NvGPhfSkOp71n+D4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EBZWksKH; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=EBZWksKH; arc=fail smtp.client-ip=52.101.72.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EBZWksKH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EBZWksKH"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=R9hKzfByaLa04Bxi2pXUds3GU8U16dPPVtUSkIOcwCHb5KsGvIKwboAnXujkvLUqFLxdfuTCF8c5Un0JMCOxr6nF03TvHj4LF3bzCFNglUdjXgyAEaBZYk68hCrKAQHfdVr0aglZld/xW4XygpEZjRf2ctU43TbqU4VFV+SOzf+JyfLs92fHe8RDVjzdFY8beaDb38E/eTVIDtd4FpUsYL7TqJr6ZqQBbrE1eVApvKqMk4EJCLgR//M4e7cbe9FHRnn2KQJ0v6JUlh+9WbVOMbtJByjvuqnGY5YKw8Zvwpa2J+Cku6ojBJK4WnX3QCl+1fQu9xztGR/qSLiCYIDNVw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjmfrBxVqs6kjFDKdyJAUJif12TRMajUdxhPbGhrOE0=;
 b=MEaJ8pQJgfBaDzs6DI7LiRIB5bnzBohKoWSCtRvhmHqGV8ENFo15yxCOTd8b9/Zk9C2QO6hS3OxuczWfqkkACPxl1ix2vvlyn65j1azEJYSVeHu8P+6XEy6yHR3iHXBv7fyANYxvwHy91Q/VwUOX/vsbkKjPHaUfk7frZH2pb4oBlnTKKEXMmXFANGwm7lMBRlIJ1mOX6GXQC73RvFERmKLGoM8OvRfJwu+aJ/Yx6/wEz3PMY9V08HhvY1p+UzivGHSQG4meHvvNGpIx7mSSbc99UGNt2o/94rJDDjJeRTp7wRZet0s3YpMnHYgJ2bcaN1D/GKokXb9+4R+QqkPVgg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjmfrBxVqs6kjFDKdyJAUJif12TRMajUdxhPbGhrOE0=;
 b=EBZWksKHfN4xnb/qGUEBM3N18erwlWLMtp/p1yGGXpjLijoUYDM78ByipgHJh5ta7T6GJEdKTvOqlurmu09lku66xD/L5lCdWCUb974ZRWbfeBIjdrBCCQlnOOwH+uXtlMFMJnWr/po+g9tdK+RgIG1wUBL2dRB0gfr6WDkR4Dc=
Received: from DU6P191CA0072.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::25)
 by PAWPR08MB10307.eurprd08.prod.outlook.com (2603:10a6:102:366::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 15:10:31 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::9f) by DU6P191CA0072.outlook.office365.com
 (2603:10a6:10:53e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 15:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Tue, 17 Mar 2026 15:10:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8VPsZoCml5p7A9oWvxqkXtf6zLtoYs2NjWJlpS281Qke2aTEsXvPAKxZm5ueXPA3RnaLe60T1cWDrMCie8D/VRpoPpwLRhb0qVeKaIJ+uq4dIovwKzlT6xNlP7bpOwcoBTtzPnoNikF7AZqw8C9dyRlrv8KsaOaMDDDwAM3jU72Kwi3RBhucVrnCslz4qmbhQWpg5zewMX8amuP2zmCdhfaWYiY41Le1/OyV3e2gbInE8eeoJtMajNEbApeKprxq9GoSjjA8EZeLplsw7uQK/5ovHS49MOzavnBKV+N/GPaypzJtCnM/IxDxwWepIbwAigioZdL3udxc/dc8ugRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjmfrBxVqs6kjFDKdyJAUJif12TRMajUdxhPbGhrOE0=;
 b=QeZsuq24Ab/pa35xB8vajQWtfZnazSkm/5FnTvjn0psDt3jK20r7r6Dt/7bL6kWLBDK1NRwzyC6C7gl2WH9ve5IM3bl4+LEox+hGeLf2lpFv3irFDU5MUzH73Fx7IwUUmFrZzsH8jLewLfUg8yyrTwb7VZHW17nPdmrvOdakmQ5Ylax+95RQ+ri36sTEtiAKIXJt0v58sCB+wWPBBE3k1TBxAsGYBDWS9za+x1WGo9J3bb/UcL4s8COIXLRKlTgxgGZO7tHdsAAngdEbInT+fyu7M3B5xcBxMm7ovoLSQ5Qbx7eSZmZ+hnjIH7nNfv5Us9sr+6+bJJeIpA2aD5uRdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjmfrBxVqs6kjFDKdyJAUJif12TRMajUdxhPbGhrOE0=;
 b=EBZWksKHfN4xnb/qGUEBM3N18erwlWLMtp/p1yGGXpjLijoUYDM78ByipgHJh5ta7T6GJEdKTvOqlurmu09lku66xD/L5lCdWCUb974ZRWbfeBIjdrBCCQlnOOwH+uXtlMFMJnWr/po+g9tdK+RgIG1wUBL2dRB0gfr6WDkR4Dc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com (2603:10a6:102:31d::14)
 by PAVPR08MB8821.eurprd08.prod.outlook.com (2603:10a6:102:2fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 15:09:27 +0000
Received: from PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e]) by PAVPR08MB9674.eurprd08.prod.outlook.com
 ([fe80::6f25:3681:7c97:ea2e%5]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 15:09:26 +0000
Message-ID: <17f18a05-c53a-4faa-8b3a-2540fbfe1e3d@arm.com>
Date: Tue, 17 Mar 2026 15:09:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf: tools: cs-etm: Fix print issue for Coresight
 debug in ETE/TRBE trace
To: Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 coresight@lists.linaro.org, linux-kernel@vger.kernel.org, acme@kernel.org,
 suzuki.poulose@arm.com, peterz@infradead.org, mingo@redhat.com,
 will@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@redhat.com, namhyung@kernel.org, nd@arm.com
References: <20260313132129.2743468-1-mike.leach@arm.com>
 <20260313132129.2743468-2-mike.leach@arm.com>
 <20260313144239.GM4153946@e132581.arm.com>
Content-Language: en-US
From: Mike Leach <mike.leach@arm.com>
In-Reply-To: <20260313144239.GM4153946@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0288.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::23) To PAVPR08MB9674.eurprd08.prod.outlook.com
 (2603:10a6:102:31d::14)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR08MB9674:EE_|PAVPR08MB8821:EE_|DU2PEPF00028D0D:EE_|PAWPR08MB10307:EE_
X-MS-Office365-Filtering-Correlation-Id: fd013cf1-803a-4b80-4c35-08de843754cd
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 Iztl+L2AUMp4HYajuZNxN8Hfh9cI8+eGwx+4OxGlDPbGGqDRKArfBNOD8Gfi7FbxbMo7i8gSUwfqU7+g5yEwRGa+0iTCKa2oLjQ4RXitbsLb2m9ObaHo3Ypl/7jQoAuctNSgwMtxriuFGXdA8j9uN8iDl2QX5x/Kydn0TIK7SBJlRsDxg7F3Q4SqRRh6VO1mGuWPM8bH2s7Vdbc2QOfQi0BG12RZEK7ozPFn4+LQaaEW8il9m3n0nAm3XALkisHy8xeqDaPJFZ8K9uBF62zO/BflrZYEi85cmK/2H1diRYjhF+Hk7yTRv83DhqMUle1J4/hf6NL8vDBYc/WHv9clNfZOB/scMO81vLqfpBv/WtyxlAp8DNUGsXj2vzaYap7+m/HSInFcRceTNaddnWvRLtnG+DxmPBC18abA85YQP4SoM1oRtp3PezlE/ONHmQyI2hkpJDF1p3Mzxcn/O+SjwligSqVUAsumCz0RAkCF0CTerCpgCN3XKHxtbksL+BEU0pAoOpr23ktzQertPi1PUecIwutej2YNlly+uO41DlGXiSvWQhgPQYBBvYt3rTGmGdvF01ioUjkPbSswthdpY0vd7dAcrSy8eAFMpef/VLi5FXTym0bbkGs0JJcJx9VOG6JkKYM0a/XPt51I1yqQPxpPl6O9e2z2FAup/G9Ap2U2L+LTeynHEME0cEiO1sQDpxEQ2zwlvHy+8Mzk8kxciVCiQWPUKvFzUGTTTW3SbRU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9674.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 voqipJJ/h7mN+0xtX4/CR4CRt67H5ieijcnvOhxjBoaE9iJM/a3NoHuAtaLAO7240b2lsvNIBI/C3/orR8XM2w80CKUX65IZ35p43C9EupoXceyY8nXxzPg1gtj68pBBUxa05pQhYlhYpyAuvoBzg5WKI2eyC0agLy5EGgM5Fzef3naX+VK8AaFY+Bcj+aXrMRRaYjpNysz0NOBe9NGWBTSBEoSLGBcVduE2ueerpud1fhQi5T+64w/DSt5x7EzzxLDVZg1l6B4dxzYb2ThBaPCBLt5WxtLzVg42kcIYaxn7XDKIsLevco4DqSux+/oITtr4RZcRubIfYc0B3LrJRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8821
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f8f6ef23-2aa4-470e-6270-08de84372dd9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|14060799003|35042699022|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YUpMcUz27/YamaxYn/yGOUD77AE69hpniVbFJSVQ9/G47uJY92tf9WzMr7XkIX2YyM+AUweiMVm9dlC/5h1ujhf98zYIfuTAYUL/qFKjNLG3389RaKY1VICORKiYrHwqR/KpW+iubTn+xpoHLx3EbpPGegNQhXrQCdIsi4nY6EGnMvYvwNh/stkZd51bImxYCvwg4vOgDeii2GB59WeNKxpRwOcGsiqAfWPeiD2eGWrxMJ0OOeVLryG+YiwtRciAffYtaQ8nygPfnxf+MW+fsjNRrZl5/aWeGrWxR04f+4zHgfbUhk4R5NkcuObLCvHQDINGifILhtH39QVIIdAIaM4IcaE9wcqAM3z9JiiiE3WaNs1NtScoIb2na+zxkOpP5rPMBW0w380hoI1WMycEgYpAFg7ZQgFyptNxZG1eY5SZmxq4n3m6tH5xUg9oZUxt2SHfovmU2F/E1rtOCAnRP6Yo3AvKhTWLksFIYiyVYPGhtzWNDi87nCNpKyBOoTrSGWPLbsVy21pscOioGoTBUo0dB1MQajH4itsHWYNtUpY/djBh6AiaKAY9SKls3yujpHLlXjnYOfWvq7rVrIw2yE99g/wyl3Xc0Cllfy2heCDDG7TuJtcjB4noq6XXcYgiMHR3d009vQcpPQlPxf4QWjatTwr0H2XpWCtvj4zT9yuF/smGTYhmn+XPHZj9OcS9YEgEJSP8Ihquf/4Xm1WibqmxpCyGLMN/fwc15FnCEDsJ6A7FrYM83tOXQJZPTM8e3MZjXEyCncm1sDora7z4Xw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(14060799003)(35042699022)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7avI3bVlTcMfuG9SeX3p8aPPQ43oCWX+9Ha1xei7QTMdWew/mHcg8nE3k0ysAZqJtHcdYcuRjgS6qeE2efqMrzUexRYgCcUwKELkisk5ePQLx3BHQdkF8coYvF+igUMM00RDDpK4MsEhG4jXG3Qb2pZ0IdlA86GaYUoMFG2ZcxHg2shxmxW0dbvmDaogNhgdmos4BsKbWimq5Nf0VbfAeiurn0q48x6fUqSA6ktL7E4nksTbVs8VQrk3E97V116J4oEwekhSqKS3hfbUpenVeylfhv4UvrAYC2ES7w9MAbpIx2k1XW0WcGsaZPf9TRmP0RnthLr2L6nFsNoON63hd/ObLg1lMCyO450hMtW0Em2oV6nOA7cvY4Djg2c95fVzNGqo2hyoJfRVu/G3PCS5c1WOZFXW1LOKSSAw+yevQae9ilOsZ2whIt6wtz0LlXK3
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:10:31.2992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd013cf1-803a-4b80-4c35-08de843754cd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10307


Hi Leo,

On 3/13/26 14:42, Leo Yan wrote:
> On Fri, Mar 13, 2026 at 01:21:28PM +0000, Mike Leach wrote:
>> Building perf with CORESIGHT=1 and the optional CSTRACE_RAW=1 enables
>> additional debug printing of raw trace data when using command:-
>> perf report --dump.
>>
>> This raw trace prints the CoreSight formatted trace frames, which may be
>> used to investigate suspected issues with trace quality / corruption /
>> decode.
>>
>> These frames are not present in ETE + TRBE trace.
>> This fix removes the unnecessary call to print these frames.
>>
>> Due to an addtional fault with the OpenCSD library, this call when ETE/TRBE
>> are being decoded will cause a segfault in perf. This fix also prevents
>> that problem for perf using older (<= 1.8.0 version) OpenCSD libraries.
> 
> Thanks for patches!
> 
>> Fixes: 68ffe3902898 ("perf tools: Add decoder mechanic to support dumping trace data")
>>
> 
> Redundant empty line.

OK

> 
>> Reported-by: Leo Yan <leo.yan@arm.com>
>> Signed-off-by: Mike Leach <mike.leach@arm.com>
>> ---
>>   tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> index 3050fe212666..f7e89693cf16 100644
>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> @@ -739,7 +739,8 @@ cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
>>   		goto err_free_decoder;
>>   
>>   	/* init raw frame logging if required */
>> -	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
>> +	if (format == OCSD_TRC_SRC_FRAME_FORMATTED)
>> +		cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
> 
> Could we improve a bit to add checking in
> cs_etm_decoder__init_raw_frame_logging(), something like:
> 
>   cs_etm_decoder__init_raw_frame_logging(struct cs_etm_decoder_params *d_params,
>                                         struct cs_etm_decoder *decoder)
>   {
> +       /* No formatted trace frames */
> +       if (!d_params->formatted)
> +               return;
> 
> Sorry I should have mentioned this early.
> 

Looking at cs_etm_decoder__init_raw_frame_logging(), this function is 
called once, after cs_etm_decoder__init_def_logger_printing(), and 
unnecessarily repeats a bunch of init calls that are done in that 
function. The one call needed to set up the extra logging could be 
folded into cs_etm_decoder__init_def_logger_printing() with the cond 
compile and d_params checks, removing init_raw_frame_logging() completely

I'll spin up a v2 with this simplification.

Regards

Mike

>>   
>>   	for (i = 0; i < decoders; i++) {
>>   		ret = cs_etm_decoder__create_etm_decoder(d_params,
>> -- 
>> 2.43.0
>>

