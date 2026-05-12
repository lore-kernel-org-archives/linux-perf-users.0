Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DCA38B7B4
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575768; cv=fail; b=E4eVKAXKeTU6NwzqZUTljNOJ2QIqwfcnwruOjqYSPxii0RkB4o5Z2t1O2MczdSc0a1JY0gS8PE65Jfl1235fSAnvAEHb19gJfRVJ+krEzHngc2HyYYvwuPPDmOq41ykuSofSLLaQ/JgBKnomZe0IX3CxR7Pq5F+lQp8RcoHOryo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575768; c=relaxed/simple;
	bh=wNnDvc6JgKrAK82LDjHyeXPOZJhLXcwHX9tIxhpjVFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TeaUFdHRykjWPFruGy+exjFR1lxjuPExCYeRoDFdnenRs2Su9qhgj1T+5kNvl9zq7ehHDfzjCZenh4+scwFj+/MaNpcaB4mABSvpcHHFGUFa7LvSLTevfSGD7ia1x/ixypbSLVXX773BPni/XeTy8Fi5a5eZJ6hroZhlcETuodQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1oJzmaUE; arc=fail smtp.client-ip=40.93.196.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1oJzmaUE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoN/LBqiSIxYEl7/YmIpKRwxrOJcQiPmVptKp9Qcsm2h9qM43OWsqzbVr5M5l8oUBUqefo3GNAxnLto7Q0ycp2ertpdp9tQEpcWcAgamebnPJRkEKcBLNz7qdiFMP4tLVeA0ToG1F1PUmJ5ycL9CB15pLUEaGM6EKL+HxpbVmbHqIOFvZ/UM2dKhqu1mo06vt8ibYkObho+YEjoJo4UETFrmQ/Mt+OSTdu9ZEKtX6WwxH7AyZ4CKmXYmAfHiWJk0THofWy4yRep0ts0Ch58+IVD3vE/Cw86tHJrfsM54PAEvtxJVb9SvzSRoRz6Jm8pEBsmwrM7V7gBdbz8nuDGp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut7px7khvzGVg7jd85JrV4BJvH9VWwCre6LvFmju3As=;
 b=BrO/yWu3f6H4xeCs9fV+B2DhgOxabJp3sB8cygGQ3NIIOif60R/iqJ6PN6sj1vcNUKQEXIdSS9NdQpSgdMwqt7n/uftmlS2CWN89VuWeoxIYZzyQhu8evkWjieIdde2tIxgJlpgSaVdo2Ronavnx3mkkerMzTluYLYGxzelkbyApCEc5or66Yzm8FziR9PH4LNoz+oy3T4AqM8MNyPoTuWDqqOE6CaEbmvTR1NcrlQEQnFGWFLKlBJk2PNB5GyIWwyYlvF4IDE/4N1azVUxJmBdT9N7crMDpcv0ojcTJiqS26xZLxQEmlbZo6AgPwzNHXsDi6DuEaTxsW+ja2RscuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut7px7khvzGVg7jd85JrV4BJvH9VWwCre6LvFmju3As=;
 b=1oJzmaUEQXqu6MMssUcS+1nkCsoZzSM9G1gp1LeDLnTRvP6ZVhxhPxzKISBKO7bjk8beBwbuRfEJbYpNW6xRTqkQrsod3Pl+mQqy6i2IPwL3kQSvcSXcEm1AbrrshHiV3IX7TWXdm9a5LV3vfaAkABEzDsxMTHV8bUxevikg0r0=
Received: from BYAPR02CA0060.namprd02.prod.outlook.com (2603:10b6:a03:54::37)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 08:49:12 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:54:cafe::8c) by BYAPR02CA0060.outlook.office365.com
 (2603:10b6:a03:54::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 08:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Tue, 12 May 2026 08:49:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 03:49:10 -0500
Received: from [10.136.40.102] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 03:49:10 -0500
Message-ID: <6e7b96a8-f053-4f2c-b15e-0e798a3514cf@amd.com>
Date: Tue, 12 May 2026 14:19:04 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] perf amd ibs: Suppress bogus TlbRefillLat and
 DCPhysAd on Zen4+
To: <sashiko@lists.linux.dev>, <linux-perf-users@vger.kernel.org>
References: <20260508060004.2575-5-ravi.bangoria@amd.com>
 <20260508182027.F2DF1C2BCC7@smtp.kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20260508182027.F2DF1C2BCC7@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 347ce0ea-b97b-4933-d542-08deb0035661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	ORmCFj25AUJdzmlgCC4EQxTnKgidKGKIwe6oRfmA0IWfNJaxDfB8PCVt7TBkgdC5AeoOirGSXKnXu2sqBUOEu/Jy4uC+GUmlcPn8FYqLwdlQr0StNZMj1OYPw16DSvGLMhEQZLJReayp79e9/+G9ud62cjjkRT/LmPhIiyvEgmqheUrxK9xseNCc9v0ueLdLu6lmsM+IKYM4oxD9/XYfStKyW9ONSaUsSlSRREdyDIZat4O15tuj/SyPMrM9+gt/HHJe8i6mpatFVP/kwPm8bn9zRdr4FOD81+spQoWz58n2x4NnCAdmVnXwSE0uoaic/YAnQ+79VJYxcbtorno8oD399T969GHFLExqi12Ij6MMIosV1rRX8k/6slPvLdr7YuyCVO9hh1uxsYteXFhkL+noGEYioKabm1z+iWjIvi8tyO7UHkyu5++KHAZ6aaUaN0QD+Nvo2Dcoj93RI+20/0EW6Euo+7Ffn/iyK/HogM2FcVi4eev1Jw1U7NIuwTp4cz3Z1Zf/cZlacbCUDMs/ACNSt/NMc3AwKKRYFmYqGSn3K5C7tEuhpQsGMC233A7d68duFAHLmeccTnpaXotGCbSXhZsCZwLAUxla4WOb4AaozbsOXI1mRxZ9gVrMywOMNV6zZbZY4TQYiZluUVvv1OHbFPsG7TsfQW1ILbEZbPwmebJ9wO7LqNaY4hnXmeRoqC2zDiB+wAddXHRA7+v8rt179IfBMm41vIeCFVlxDwI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QPAhmYgJ6wuEE81/oJ9g5GjWXz2y09bjfGs8pLkCw/X6PcdE+8YZ8RsJIP2us6TsddUn+yZXilGhQaBPz039JXsbkp6+Pxt/TeDQ+9KCUEUHr9JWL1XrOmzohxQWGpdUI9CxyleUpIHEhggln/fk7SQ7COi5QUkcXbbOz6T2DI6+l4MiabVtbnAZ0WFY+RpawQkWmoJJrh6fszAXXtNoUnyUpCycETfgBKSZg/3DTxIvmk+DzoIVpsG9gp0fmcON0sDorF/wL2fHFa0XL7uYzUcOHmsjFdG7Y/Dv2sZyIHhElUAPUfLcLZJlCpjqC+Vc0gIzZA8qEfJsPFxtXeDp4A1bczdZPTxlkkoapSnTjTBfhOg8q6/SxU/x1sRQ2VQsT92B6BwnyaxXt26QiOgmWo5KVy8aEevBTioMTqYe36lc6M2BPDqpp3iR0kq2fDPV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 08:49:11.3041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 347ce0ea-b97b-4933-d542-08deb0035661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403

>> @@ -253,8 +260,12 @@ static void amd_dump_ibs_op(struct perf_sample *sample)
>>       pr_ibs_op_data3(*op_data3);
>>       if (op_data3->dc_lin_addr_valid)
>>               printf("IbsDCLinAd:\t%016llx\n", *(rip + 4));
>> -     if (op_data3->dc_phy_addr_valid)
>> +
>> +     /* Use !zen4_ibs_extensions as a proxy for Zen3 and earlier */
>> +     if (op_data3->dc_phy_addr_valid && *(rip + 5) &&
>> +         (!zen4_ibs_extensions || op_data3->dc_lin_addr_valid)) {
>>               printf("IbsDCPhysAd:\t%016llx\n", *(rip + 5));
>> +     }
> 
> Does checking *(rip + 5) here suppress valid memory accesses to physical
> address 0x0?
> 
> While this successfully hides kernel-zeroed addresses for unprivileged users,
> it seems like it cannot distinguish between software-zeroed values and actual
> 0x0 addresses. Could this silently discard valid diagnostic data during
> privileged profiling sessions if an actual hardware access to physical page 0
> occurs?

This doesn't seem like a genuine concern. The first physical page is reserved
on x86 systems, so normal workload should never access it.

  $ head -1 /proc/iomem
  00000000-00000fff : Reserved

Thanks,
Ravi
