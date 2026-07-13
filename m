Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021125.outbound.protection.outlook.com [40.107.208.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3286334;
	Mon, 13 Jul 2026 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923236; cv=fail; b=bMOTutQrWI8cUuaLlCyHGdaclCIMOw393+FmJ6s9xhhbxHoodpWhRddRNI/x4SNTXmh9s6Ng3rvIyP2quEg031zXp2c5uftfn1Xmj1CMM+cXpFY/uIiSl2VHdZFZxceom8r8askzSqBFmJZTGTA9/SV1edYlo5qaoxnWx6POrLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923236; c=relaxed/simple;
	bh=W2f7SwpOwu900peaftlNTz24Es+cKZ0KxQs7t4RpMtU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=R5l5xl/v2Md8ADn0/3aG2Ki5s/FpEufO5t5NDaX+Jbs6TOn5AHzNyQdKa+AuGrBZxWtvR+EF/7Nwiuk1fsEipyvRK9dX4PnaXJtBzs/WMid84xwKx5upyxjvq6xsrXh56w/Jbdli21Nou7LwWfrQylCObk19h7Wv115cwLM2/o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=oSL1YqGk; arc=fail smtp.client-ip=40.107.208.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="oSL1YqGk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9pxHflOrjRzGsrk2LE/yY/mIHag/I1XHDk/3WkfuKXckIHHtuC4a4oNgpTwl3+O55o2K4mh4JUHkAiPzHzuxCRi8GY8ldkHInlaJMrno3GPfLcqX7nJKhqkKohfh9Y0RyTZshJZ9IcHSMYDe1XaAuMu37F5Ay05PYBCyeeOOym4fuRE5hp14Mr5Dr10LTUQzbC8JIynbI5ckLRKwvspFO5PUxKhNccJXKWMNbsvxL7afEltknLLy8eeuQVslk0mdTa5M7Ql7bw6OHkbpIU4wbVGNxoeW+jLmfQ+xqz9ycXgtnQ0q+Pb32rN8IOwKTdSbVLWeD7lTC9i8UsbK0z8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntHXtdvIWdfC/5qc55OR1Wsjy6WhcrkEBi+zXA+wai4=;
 b=p8N3Kbth+UBT9rNS0HboU9WYQc8/LKj7HgOSHgSU72cd7aXWT5cWPeJqv2cT4ZcSAnaJW0jWplP6QFfQixg/z29TYQrbGrl1XmplGj3E9n9H4HsDPYFE7noeslZqzSkQWVqEtn26qJ0KyoXvbRkorwHttDFgVCKlv7I6eNMmyxumvy5RjpO8uGhuJYCdlwsoQS12zKi5XHhp9+MUikBdFNFwqAwn7erd9xr+BaptS0mNnpDuaGFhXscy2EneUgggwr6IWHx4gsFWEo27FWmvsKWe0zdlfA7hi2+cZNjUHF6n2CxfqS+5NhpjsvdlNn/uUvwOTq8xk7MqOWVFtDZtNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntHXtdvIWdfC/5qc55OR1Wsjy6WhcrkEBi+zXA+wai4=;
 b=oSL1YqGkItZDA7lGnYyByvVQMa/Z8AgjGa7Lo+iTAagqE2SIAhHmbWpykNMnhu0AmcExtKwgiMhpqYf3uL12unex449cd98EEC4/8cLVXooFFnfRXHuYau00jTQiuAyPRfcE/6C3dt9iDjfmxwrp8MeeEkTwYZDUbhkOiBlJIsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 SA1PR01MB994407.prod.exchangelabs.com (2603:10b6:806:4d1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.16; Mon, 13 Jul 2026 06:13:51 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%4]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 06:13:51 +0000
Date: Sun, 12 Jul 2026 23:13:47 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, 
    ilkka@os.amperecomputing.com, bwicaksono@nvidia.com, 
    linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/4] perf/arm_cspmu: Improve sub-module error reporting
In-Reply-To: <f8bdaf6c3f0ec2be905e43766410177d3c409690.1783605641.git.robin.murphy@arm.com>
Message-ID: <638938a1-63b5-3d65-024d-9e2ede0ecef5@os.amperecomputing.com>
References: <cover.1783605641.git.robin.murphy@arm.com> <f8bdaf6c3f0ec2be905e43766410177d3c409690.1783605641.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:303:b9::10) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|SA1PR01MB994407:EE_
X-MS-Office365-Filtering-Correlation-Id: 989031d7-95cc-403e-4d78-08dee0a5e8b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|11063799006|56012099006|4143699003|55112099003;
X-Microsoft-Antispam-Message-Info:
	laZBxtSbZNM88Xo9+NIfWmhzIVpBEWA/RHObCLM7wSEEUhQNpZgMPejdEwL0s0ja0rrDeXlBBRcGB26fTGz+I4RYi9LbdsuelVp4HunK9nI5g7HndOFgbzJtNpekMuG+GceEtDavqZPKgJXO9/yBTTVmVD1/L6FXfiijwY7x/3AUQvvWwePqHIbgnjFp3J/n3fe8DkZ35psL67lPjlSMAZkm2eh9XAZ2P3ytoYMkmquM9WgmOvR1NSN6RmGJ2rs3gQquUdyqzSSzhBTTVQDT9lQ8uA7Xh/+YRtEy9U9t6Jo2FPYVwEBkzoQYBP/vy7VD273S8tTocdmZPew59LAgFMu44iGL6CpmB1kKR7JwIVWpFrpFa4aaofCkdu/ZaUvCgPtJfsWfCRt1gAoWGKzn9uEIVdYB6SbeAAoFDP/tt3gkHBQu83o6MfKdF4/zNzECtOiu1KERFxNxhoJVeVTf6R2pPlQBNVKNXcQwJvbge/zMF4VFBnn9m9EziUCKpjHDcfxX+TB85rl+KO6bc3jMzBLdiHlVU68+vFQVraW6Na6+cQDqtQ0BiO/cRYpcwpXwLDa/uV8QLtwC8iaFJmJ49ZTHw5iH+XXTkAxaIPX45GjNkWqlJFDxAweDd8O6LfRxRfmltA6RqohL3UMNyaP8TDcQcfxs6lMX29UW+6rQktU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQOp3jLwi/SOoLNrs8pi3rWQNCUJq+P/j1Z2teASraNBT747cQ7UAAKiFQLE?=
 =?us-ascii?Q?2HRBNDejP/DDduF83LPyfiCCKR7Dz7GGRTOHewvCtTAzniTY/Rgydaa/OVQ6?=
 =?us-ascii?Q?oyJkHUlRL0AsKmTpkjtSdvtwwu+DIlD2dKWSm2pmYuCdWI9UdqMX12ZfLSPJ?=
 =?us-ascii?Q?qzGFaOZLX9Eoj/PRX0C9Tn+eCyK99OnHgXYFtgYXZ1rPJ3goXY1bO84u2Y8y?=
 =?us-ascii?Q?0bU3q2VT7KBCTOcL8BARI/Uawv3C4rrpmYXTAAilVCQtMcTRnqokTAld/zr9?=
 =?us-ascii?Q?pq2xB9mWUenEjaV/xBuc7P4FPlRGpvA++pBnm9YvZs3UEW5SL9KpHcuXyX7E?=
 =?us-ascii?Q?XCndKpMZihhRTIjo/byHJfJW8whe5l635j5OaULOFxTaY/KFGOTs7WaL0OZ6?=
 =?us-ascii?Q?LlQmeqJa2H6j5NmhDavEmusxwjr9tySz4+WHnJO+PVYUwPDas88wjzadlFHl?=
 =?us-ascii?Q?DItDsHMSn2G8t66PGo3gpf3Z5TO5z3nEmuXYo7yFEfTb1qy59zoK+Ip7srb8?=
 =?us-ascii?Q?CHTF2sYj3QedgcLTk6OlSEliC29ALNUgQpNW2ZULHoPcDlYKzdUsmbgX+pnz?=
 =?us-ascii?Q?MPWEh4++ieeyRmfsluqsEGuIwX5eZgIjOrHBjmpgYM0RXDplQMwCqm8++diP?=
 =?us-ascii?Q?EY1ygvvOV/G7Cuweodnr6shNij5DsOeC8DkDfjEH5C+j0g/Z4XSgtCHTFKNa?=
 =?us-ascii?Q?RhxNl2N/DXf3eYCpb+XiyHAPsluQ/OKf8TcL4de6yQEz2RpbFTLqjhsFwi1X?=
 =?us-ascii?Q?X4J9Bdz5uIjj7pa6A5IKEnkpQqcf3+/oywSZEkHSkLi8Bp9L2lFAu7Z3Tree?=
 =?us-ascii?Q?yyJbyLv2Dwf8r6LKrRMi/sNYenMzRFC6ivirp0TrEvNudqT2XgsGog+KOGgF?=
 =?us-ascii?Q?tIpNtOMBu0bnPaETJDLHxOf09AUaesa6I4GWKlBKOr1Hq2R6SjtV4uC0P/EP?=
 =?us-ascii?Q?CYbBWt37QuSlDVlZto5h0VbequUctsGZ5d4ZU1KOE9yq+T8pK0IgGUBR3N5k?=
 =?us-ascii?Q?1zRBr20/v/UaXYySyFIvA+uCXivKIp3fmpwKv22eOJv7HFFb0zzs73Z+rsqq?=
 =?us-ascii?Q?wgxtqvyy2X60ZHuv5oasip3m2X8iEWudpveRliY+CIy2iHtev2jQK8Dhi9Sd?=
 =?us-ascii?Q?QTrTnVZH2Cnfj7maicpmb45lDHihqFDSPtw8BjJs66LCZxLLQN1LKWOuIcRw?=
 =?us-ascii?Q?p9Rvey540i3pHHXtj52/D22isnJtdaZkHD70Yj7g8xFBa0qDAsEnv1zGEZoe?=
 =?us-ascii?Q?JucS5oLhMTVkBywQfq6ZVHg0MZp3M7HbWhZA5Gp4S7E28K/Cweluhfz9/lYx?=
 =?us-ascii?Q?oe0JVs7prBBx8xyd6ERhfSaKWdfsu/nl3g6TYbh9A5LQSHxNMZu502xGIaDt?=
 =?us-ascii?Q?RsSiWc459O7hWqAZyOelpBQWb8qH2vi0Y8DI+YXyX1i1FImJkn4D9ncTi/j0?=
 =?us-ascii?Q?d3/w+0RmB/0TH7qEHUzplTY6yrtLVVMRgekSY2rHm1NZkGwYkwhI2p8qBb7P?=
 =?us-ascii?Q?jH/sx8cBb2Fu25A3t7+cHN5S6OuDFMMLqICvfp1dlGovgKZTexleaZ3JOpbM?=
 =?us-ascii?Q?sLs4qoJH+hAAHH1vBbtM6Nr9K9yymDOtMhZSx15aOa5iYEqLoi4wNGEY4ma9?=
 =?us-ascii?Q?VRCwnlbpadB9znp7HKEWCdbxOY7E5hOcrR/4hxTmDb4w1+h7V9or7Si93wA5?=
 =?us-ascii?Q?TGqiuy/FaF93DSVOA2D59R4yzAFNP55pDwJIDUhloPG9xlptYoeDky5vsxrX?=
 =?us-ascii?Q?iMkfx21ubMHiEj884WHWiFay4xzwO6k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989031d7-95cc-403e-4d78-08dee0a5e8b4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 06:13:51.2537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7s/aKQZxeJAxRVp3Oc7zBdbjtLis0v7H4acSv8vqrRMZR29qfmHLncZR+8GmiV8MX8BNXR8S+IVKwFh/5FlyYFQFeNqIdVLyzKHNdXEogDJyoVCxq+RmunfUbLmwhv5v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB994407



On Thu, 9 Jul 2026, Robin Murphy wrote:

> When waiting for a sub-module to register, we return a bare
> -EPROBE_DEFER that ends up showing the end user:
>
>  platform arm-cs-arch-pmu.1: deferred probe pending (no reason)
>
> wherein it's not necessarily clear that they might need to take some
> action to ensure the appropriate module is available to load. Let's use
> dev_err_probe() here so we can show exactly what we're waiting for.
>
> Similarly, in the case where something's gone horribly wrong with an
> already-registered module, we can use dev_WARN() to standardise the
> device/driver attribution rather than just open-coding "arm_cspmu".
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Looks good to me,

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

> ---
> drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 0570be74d11f..0b26a1588eba 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -438,13 +438,15 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
> 				if (ret)
> 					module_put(match->module);
> 			} else {
> -				WARN(1, "arm_cspmu failed to get module: %s\n",
> +				dev_WARN(cspmu->dev, "Failed to get module: %s\n",
> 					match->module_name);
> 				ret = -EINVAL;
> 			}
> 		} else {
> 			request_module_nowait(match->module_name);
> -			ret = -EPROBE_DEFER;
> +			ret = dev_err_probe(cspmu->dev, -EPROBE_DEFER,
> +					    "Waiting for module %s to load\n",
> +					    match->module_name);
> 		}
>
> 		mutex_unlock(&arm_cspmu_lock);
> -- 
> 2.54.0.dirty
>
>
