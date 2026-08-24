Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC6280309
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578528; cv=fail; b=HWVrsbq/gq30mJs37HA5YuF2QoIKbIS5QqNOXEzgfV9veTSbGNHl40MJLDf22Z+U7SqSj4O12X2lwfRxJa1wL1JrcqCH5GzZ8fq6Rlx0sgkjF9VRYb15rLEu5wbi4bhwUSGJT96vneqv/vzMum9nkmTlcVRlPIMWKuksBUNkXRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578528; c=relaxed/simple;
	bh=ReJ4elw1s2EbGpGA67N4/xZc82maNRQEOtrgEdNE+Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=fcuidrJDDNFrNahP44IwqN5P4TTRWoQAcxEzD+CwkvqLzHfxyR4LCAoKjP6z8dAAz93qaiHMIW4kPAouX2TrB9on+5FJ65r5Hh/wTE3tBaWqFMWhIPyRkKhBFuzunbLEIeZ4I8aCQPCmLgTxjmaZ9AY/Ld162PNLiWtesvYmYek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GM16iFJY; arc=fail smtp.client-ip=40.93.195.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GM16iFJY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioUwnPJ7g156MR4sSlkI37hp7KZ7/DHE27MgQRz5KRWauvUb+xvk8nF0kBrlUsAgHnZ4F1rRiXwxD2rsLZN2EkQcW6991u9dWadw1pkFAj6oIse777Jx1wF6mEctUT0LFt46D2jKJRS22Ie9aOrYNR9MWaHr86Fki3ALQ69Uet6mixvJQoRViRXGAc4FCsHCMhnRjEHy+NrnfX7ZPUipGEpaEyhuNo6xctwnlEm/1ssRJ4bpqSII0u8W7E1L9wDv5PDqf7/5wE5eAndNh0MbS/+oU+0h4Pr+CTc9tUEa00x54z5QuO/kPxCU+0c4993YOrSUjITmgMwiOEADy41ybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd+hHbqsqOdNo8t/tlFoQc70vIZx+Q+Q1QGiLDxEuAc=;
 b=e9mBkIy4ydIznYPfWC0p9MbZlStuImMJJ1joPiOSopap/liPIHVs2XVQzfNrO5CSMlQmp54Et87PRH5w9IX0ByXzc0C0m/2I/uAESzuAOaAhy2uN6poSrpsIyVesaRi2r4Kp74ob4UFZekwdm8BDdogo0uYGqruPBxvk6eZzX0TIRcI8oExstbPVtxil323r9MTsb/8d/bF32abmsdUK5QgeXWMRM4fdsGbJPlv0RKyqLOmFJT9wZeyeAFJw4cjSa9wYnlTz8QOsu8D/UE+C5fgXZQh9PEo9YfzFgZyexn6U+rF7IaL4IiufaKmtAZH7RchH5wmEouibkdvMK2NkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nd+hHbqsqOdNo8t/tlFoQc70vIZx+Q+Q1QGiLDxEuAc=;
 b=GM16iFJY5gHDdQYMMrVlpKvH6RQFWV3GVD/WMLnxs5U32tAa9Ien19W7hDU0CLc66m3gKxi2intrDI2j4SIHcjSkJGSdefhHe0bDH/BlPo6IZtKZR+eZRsRcN6VityyoEszP3rFJ9ft0bjs8WeZdL+ESgtwhEXktiYd6N3bD8tU=
Received: from CH0PR13CA0041.namprd13.prod.outlook.com (2603:10b6:610:b2::16)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:35:18 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::6b) by CH0PR13CA0041.outlook.office365.com
 (2603:10b6:610:b2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Mon, 24
 Aug 2026 13:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 13:35:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 08:35:18 -0500
Received: from [192.168.0.101] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 08:35:17 -0500
Message-ID: <42e24100-f4b5-4192-8912-f0fe7b9273c8@amd.com>
Date: Mon, 24 Aug 2026 19:05:11 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] Three problems behind broken "perf --call-graph
 dwarf" on AMD: IP and stack dump mismatch, libdw fails on lld's layout, and
 the unwinder fallback never runs
To: Gennady Kupava <gennady.kupava@gmail.com>
References: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
Content-Language: en-US
CC: <linux-perf-users@vger.kernel.org>
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: b01b9eb1-2038-4d33-4738-08df01e489cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|5023799004|11063799006|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kdji5FROTjRNED2LadxG0M8Ni1X9W0JJ9+5xc40zTHqd5si3vf9Kq3b/MzVVkc8aOOHQrUDZpDY5EGclcOaCgTtm5kxCviNqkg/iAw9Eita2aCAwePmqdlSnL1FumHd2VodnO8BCNRyyJxhvzTNHuL6zJ3xak5Ix8JCEhjZcWxy3KHZW444gpso2yvPp5ynyDxZhe0zU/jwS3VOxLGrjutRRqfEvW7zvUorYfzXREGa8Nm606NWLVf9y2VwxahAjynn/jiBgn/stqqvv8OHVLVvYH6nyF1T8syEC+fICnbF8eN65+EjT5Xq20vScaqgTrEQq+CZ0mBbH05+EtUuqitJaLEnfCpI8bGzMLSNb2eSKcKpZ87uHlHx0p/DvHj6J50LWdoYsJFhjQnAnTuyWhM2M4Je8U9ecJO9vWICfBRBbk01igBo9JkDwPsLJlpY8CbDUR+C8Wv5sKfIVI7H+Z50lSYTNC5BHkrx7S4+UR0QR4mYr33570pdtrVbSldhBOIN8sGfA/SFC0+48bjgbei+2tZC2sZvjCQyo2fzxf0sXHULEQTQnfiHizXSaidkO7LJG6MVY6vjAZPIasz7KKy1ZxjISEpdUv44Tnz/hssrd6iAdhq3dDgG5xUEmKml3DylN2bWGDzzlYFiN4kcFO6JiJKq9rN91tF5jnFn6xNHG16DzKfY2tHXkUOMYWMqb96cy7hjyeY5CaC6EFtvYHg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(5023799004)(11063799006)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2I/T0nLCczyf7PtUDUcxTViezV0c++IU7bIbQ4C9cVau+3dX1ZWVDF4BHNHOPSJOSgtPjlRu4464/yHj9ya2JfrktuhkKYlrGxhZCuI80Eyktjs/BdRJUT0AdAoF65Rth5ufgg0tOn95SVhCfjPqqLjfOG7llFsv9r74POKcm6BEQrHpkSDswNg2ivc+TlgwaP/DzTE1zH9cZX1i58Ea6hdoeivbQf4ie+pW/tgj1vuujHAyBzVWba/Rl2tsbWOEktoO5QL/5NCiEkqviqUprgLoroPXULaxawZgRFXGYZpZ53hORf3ZN+y98O5G8mtIKe8l12fX/qq0xPKzu893njkewYJTRGwItdBIR3NelYRoA3hWWdFzuEPHtiJnCRtzhe7VMrHC9Kel/yDAjUiiVMYGL7CeZY5X1dbSvsla5EQLuLKSRZQHqGWwINtbocA3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:35:18.5326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b01b9eb1-2038-4d33-4738-08df01e489cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224

Thanks for the detailed analysis. While I'm yet to digest the whole thread,

> Suggestions and questions
> =========================
> 
> 1. Kernel: the fix that was applied to the kernel-side call chain -
>    passing iregs rather than the modified regs - looks like it applies
>    verbatim to PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER.  Should
>    those be derived from iregs too when the event requests a user stack
>    dump?  If the precise IP is worth keeping in the sample regardless,
>    should such samples carry a flag, so that userspace knows the IP and the
>    stack do not belong together?  Today nothing distinguishes them.

Samples with the precise IP are tagged as PERF_RECORD_MISC_EXACT_IP.

> 2. perf: precise events and DWARF call graphs are mutually exclusive on this
>    hardware, so arguably perf should simply not let the two be combined.  I
>    would suggest two rules rather than one, because a blanket refusal would
>    make the common case worse:
> 
>    - for the default event, drop the P when --call-graph dwarf is requested,
>      silently and on PMUs where precision means IBS.  Otherwise a plain
>      "perf record -g --call-graph dwarf" starts failing outright on every AMD
>      box, which is worse than today.  The s390 case in evlist.c suggests this
>      kind of substitution is considered acceptable;
> 
>    - if the user asked for a precise event explicitly and also asked for
>      DWARF call chains, refuse with a message that says why and what to do,
>      instead of quietly producing a useless result.

Another option would be to report the IBS RIP only via PERF_SAMPLE_IP,
leaving the original pt_regs->ip untouched in PERF_SAMPLE_REGS_USER.

Thanks,
Ravi
