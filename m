Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2012248BE;
	Fri, 25 Sep 2026 04:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790309026; cv=fail; b=TxMg1AsDqD5d0GZMq24X+JJ9av/d/vHVqr2CsKURGp9KzOZLk3sQYlP/8Yyole1WPgS9kYg/V+hXlnCmVCtPWO6BlsShV5z3JjVPyAfowpOHt29bao51j3KOzl7yUKTcuRjWPgVjcDHbtLauzEmjIjBCTzlIUxcoVTqJ6aphtT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790309026; c=relaxed/simple;
	bh=2lwGGHoBmDmOoURKIIJlVA5o2ts0zsPJHU7e5XlsTLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qi3QfSwNfJYSgNW0cIk+ABJKKVr+njNbMEJLy8VK6r3PR3P/B/tmn1c3DDdpDkrvbnpAX9H0PjgUkTtr5XTG1Grd7hRGpiPynGFdXuqubgVsdjU3/5Wczan4oqnkzfu9nLnfcb2You7v36CUIq3Vi1Fi/gg3e9M4If/l/EGhHlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=URos7oWG; arc=fail smtp.client-ip=40.93.198.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="URos7oWG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShPe+BH1QD0KQPH9qrtq+d5hTC8678MH25KGX5cSg0x3KjxO6ccxjsYTwq2xPEJ5TNyfYPiiyWad3odMVgJn4flEYAAcWAY76WmGO25s9tHrOmHRcMj00EbyuqWfV7PhQJn7HbpjApLG16DS3TwZRUqxq9X0TEmZccUiO8Efw+HjG5r0s6oh6ZuILfhIQTcCSZR9ljBxjc7jPdZjmO3y4UJcQ/2nNWR69bWnfj9vAuDkYMltF2reYHwm5Zh6k1Q3c2pxcZo9x/txKZ7hGp745/rpnO7LTrcQog5+PYEo1TDMwnC791kQwAJeYo4bqoQo9paLTxPaAeU78rPQU+uUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsnnqac8gfyBINPFd3ZucDZhpMfGVcVDgb5VLK2u7RQ=;
 b=ccdmz5KoTYsnGRmaLDQNa/vfBOOv8JuZLIY6B4DtIuEbVYzviHAbhq2xm5yLdjIIFgFXl/ihFyaungNlkDJOcbVVD739ujfBuOnNvtVQ3Ipf08lRENNpfCwrAc/m8mbkjs7F8KGvKHEt1lrxND+pnhCCFxO+L6uhG2JOgzGZjhzrOvTRiHxREbSnujQaIFK7ArlNk2bR8wmjBOmQDGxhAvAC98pmM1v+4lLvsO134WdmKWazokt+CP2bMqzlBeG9/rUkP1Z9YHLi4M2MPolmciZ7RDK3nM9cFO/iHwFAqSZoqMnVzQtHgMnWbeyYOEslbnCGNBjmBqz0shUuFDKm4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsnnqac8gfyBINPFd3ZucDZhpMfGVcVDgb5VLK2u7RQ=;
 b=URos7oWGzHNESOFPIzrDlt3yNhjbfxw7drGVAbZgqzj4UWaPXuuke8Fe+RFhDRxOa2t+QWwBGZskezgBgsQqcHzO4iL2RCPOj24HMx0E016Dl5GbuEMAHYw9mYGW3OLlj+0QvGGzqwtktFqf7bgk8hzjAt6Q3vkw7IPKnvIURbo=
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 04:03:40 +0000
Received: from BN3PEPF00022BD7.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::c) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 04:03:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BD7.mail.protection.outlook.com (10.167.248.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 04:03:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 23:03:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 23:02:47 -0500
Received: from [192.168.0.101] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 23:02:43 -0500
Message-ID: <76ef085b-e8e3-41a5-b029-2cd0489aa430@amd.com>
Date: Fri, 25 Sep 2026 09:32:42 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] perf mem record: Use the IBS swfilt filter when
 available
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Clark
 Williams" <williams@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Arnaldo Carvalho de Melo
	<acme@redhat.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260924212809.1733663-1-acme@kernel.org>
 <20260924212809.1733663-7-acme@kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20260924212809.1733663-7-acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD7:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce4231d-a157-41cc-7835-08df1ab9fb44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|23010399003|6133799003|18092099006|18002099003|22082099003|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	OjG3DDLTXnv8TjK0/60KaWASJFlfh5ZKzRHK3Qi/8vWDfM2UhNAh54l6e681swdoA3yZDSt+A9HOWCCua/iu7Cm2UmFCRJmbrZK+2v0KjC1sa86H8UzhkZFTFFgOCRKbi6bqD7PlGrbdwO61N3O6+M/IU426d78NWdxzMaCmp658aCGtXS/dc5SYLF3KwvuVBRDe4qwcEiL5Rp0M1kYDoBWO8jXJTRUlOJuKqCPY5KGkJ+34mFPFthNpd0Oko2iYeoOMoy1geG4dz8+Q0etUUmFWKT5Q0T9Q6GdUiufYfkWR9eyUKiljWmSHf0WXYLgMgm3Ynecp3uYCJUQgY+3kveZczHwpT0bdIz9X9X+RI2iewg0FGemjUoYHsV+iQZ5A3lxaOgEAsZ34xE8sID+61CYVQrcuMlDTmt0TRit2/+Wj1cyzwAdGIlZ95qp/3ayHBBccBWGwsFrPxHjloK+WuU8KVrlt5VoaHg2ur1RPAE3ZUVUDzKIQcDxZDcaJV6oTDGEGgCY+DzTjMtub0pyNeExo/0sIUBVp977v3HboscJJW5f+xdu89u+U4lYylivK1BzpPvNkwJf0nXLmmWPGqSzthL9zYMMB9zd4Z7ciYZRjLTnBtwMydoK2fcmVMYd/qkOmP7pThGS9TXoisHmzDgqMvAStk6+Qep5X2vkOicJV6fAfgTxbL09NardydxHlhHKQDNnA1K3exuq+3+Ad+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(23010399003)(6133799003)(18092099006)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E+GVqz9qaoT4LWUPq6VktxPTNY61cDmX0IBPm3qNpKUzSZyAOjA6+UEFiGVMyVIRlENZ7RmoiRw3ssScRT9bk04Tv7afdRdBgt6mPTLAMoOUw+FY1EREb1wvet9c7hzNtKL5B+afe3/Q8Iz5u74CdTkz6dcdaNh8dhQuP509CZ3jFlU1fnZ5QTmtsIIdq/pmXE1tp0gDQzYZsQfAUl/w5FWUviSmKt+BI7EbKze/GXOwmO5f3g7tqShRO7G7usPhc82LgaOuXfwr3TEgtDDOegvuL8ssl2WZ61rDVJTYRHxqso4VoQ6QnEChlmRYOZ00ZY939IhgzRKTR2uKJ3cQpZO7/Hwg5sRTbBCKPjxgNwkbo1oQmOg7VmKeolNxdh01ltr+1C1Zg4DK7/Yu0UvOmMyz/+Jgd4zgM9eg0NBgiX+Jm6Vz/9xes3AYilmc7Gbb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 04:03:39.6351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce4231d-a157-41cc-7835-08df1ab9fb44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819

Hi Arnaldo,

> IBS events with exclude_{user,kernel} bits, as used for per-thread
> recording when kernel samples are not allowed, are rejected on hardware
> without the privilege filter, so per-thread 'perf mem record' fails on
> AMD:
> 
>   $ perf mem record -o /dev/null -- true
>   Failure to open event 'ibs_op/ldlat=0/u' on PMU 'ibs_op' which will be removed.
> 
> Kernel v6.14 added swfilt, a software privilege filter exposed as the
> 'swfilt' format term, making those events usable per-thread.  Give the
> ibs_op memory events extra tables with the term, selected in
> perf_pmu__arch_init() when the PMU exposes it, keeping the names that
> need system wide mode otherwise; the knowledge that IBS needs this
> stays in the arch code.
> 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Suggested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

> + * ... Keep it even when
> + * the event has no exclude bits yet, 'perf record' adds them on the
> + * first open failure and retries with the same name.

Currently, 'perf record' fails rather than silently retrying with
/swfilt=1/. The reason to not transparently add /swfilt=1/ is to
make the user aware that software filtering is being used, and it
is not overhead free.

Thanks,
Ravi
