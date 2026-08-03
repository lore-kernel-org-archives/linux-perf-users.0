Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660DB40801B;
	Mon,  3 Aug 2026 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768057; cv=fail; b=kpNKeWaYPxZ6+xRUH1lTaCh8RO4ojkox04mAty90SBSqjl1OQI5tcu5oBxeG+w9GYVWcL73cN/CzHcZgu39fG2g0nrcvfH9px2Al4h4d5giWpDSp+CMmy8MEUTGFGKenK33kJa/qzhxC9DVibAiWwEvwWkGeO08PcjOz6t7uZmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768057; c=relaxed/simple;
	bh=X9VJdRQE6tbrFZLFHorkfyt3W2prAGx1mz13sW2KrqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B2ZVY1AeI/nAHOOkTdYP5tDL4wZ2IqL6cY6g8pEfdjM6Lbz5etKeSGPDnEIX6bD2v+aIQZzDqjV/xcveye8PcdRWXe83hdsT2v58UJ/pgr4pN97nIjqlpCCUjb/Z8id6W2gMye8u5roD3FUnm3DLb1NUyVgXbRMLYSe7Mpieeek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mIrM8ErM; arc=fail smtp.client-ip=52.101.52.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mIrM8ErM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhaIBoTDuM4O+YjTU6v7j+uw6TFNROoaFXr99JnymN124gMPYzE9sCBa9B8KqKzOZMnlp2mflddOxwxWxOIEgG9Sbfji3hPa11WYmXhvWFLGnfx3CKOdIBApZQlxP3tQWvG3kL9OQo6U0XaTyLpXlb9voZvPuaxwgNeHQPnc2K3rdv4uVJW9oNzWPGzsiZzQFrTI0ICnuwN/bmbHMnKqkh7oTxtLvcTosOYik6WaFs9gF2Eo6rF30zK81deg1F16aJ8JnWbnoFT6P/sAQwjRNlkBHmHWgdg+gHvneWbiTGqeJRnvokSgAHaFNF5zUQyUN//sEOvipSDbCwFiwUw+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wghl+4vznwSZVUvRx5XG+xj3fCFdUW9JkVEbf7zAsgo=;
 b=ojQg5CESWAmuX6yGJSpbP653vyP64mS5SGXsYVLZgaMoyYYhOx2qtS8o0iBwPgqnBJnxas+plAL2jmdowxroQQS4vB+Dhd8KHUhQzoTDINXPhen7LRufXEj5c+Tsju617ytc7wf8lAXaWK5jDPe6bYPUofIcBHYtTZEpLZ5GEpDqiTbe0yc/zXVI96QbbKbkKKm2blUt9OOG3mf+EM/Z9b8JkBsZ9nv2ASjZT6rjMWu15c3pj0FnEsCZTrV5pi4KrdPwRHR0C4zzZ4Vgo7pA2iIossG+XyjKYJw3/iKcDj2pSp6hQaP3lnoolD1cERz8FchDoadtVSPEqUlQ5hYHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wghl+4vznwSZVUvRx5XG+xj3fCFdUW9JkVEbf7zAsgo=;
 b=mIrM8ErMu7qr4BMy+4KzC6AuiaE/CD4YgdgMSvAyrnA2ey1oOHn2NwKHcCfNQFOZA0dXnmKCIsQi0lOk4pu4qGKYvDe26Kl7pmf2vP+r9Ynf6udVsFgxvY33L6OIyZu8zY1V7fiGjGFh9sYwdPsEte431sC2e4uccm9tTHNy19xpcj2rQs2b4gxure88c6Ct/b1+mnN8KN6tJfrXhSdl+yW0psbKkKgiNjdXQVYvB0zAb02MT34rl6XROGZj1juY+S4t8Kq1F4bY9T23/kYtwNn2IJSG1HmK7idytuJo9Omv64zAsRb+EhkR+TQG3xe2H52I8S7C8mtAvkWefVNnpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:40:47 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:40:46 +0000
Date: Mon, 3 Aug 2026 22:40:41 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net, 
	robin.murphy@arm.com, sashiko-bot@kernel.org, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 5/9] perf/cxl: Accept an overflow interrupt on MSI
 message number 0
Message-ID: <anCoCMWU0s9SiNWL@MWDK4CY14F>
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-6-dave.jiang@intel.com>
 <anAs42gO1Yd7MCid@MWDK4CY14F>
 <2d89c314-c0d9-4895-83cf-52f12a3f6ef0@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d89c314-c0d9-4895-83cf-52f12a3f6ef0@intel.com>
X-ClientProxiedBy: TPYP295CA0036.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::8)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3484a9-221e-45f4-766e-08def16d3404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|4143699003|11063799006|5023799004|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	QsxFxQFrUA7Ys0sBh5rPJlnTL+yoEe3BI6zUDp73hNQshaCyfk4vDehBse5r23uj523cleOySQib99Xa0VAS27LChApYrnDKqwlf2ypFqX+LDDkEp67weP7aDzaTy5WdBFthVTVSygurWRrgxW+Vi1uZ0wu7jjbHzEMUzM54FfY7hBnIOX9JywewDKBgzHz+QH3/24eKvcnxtd/S1n/zLd6h7jt2cjXlYS05aDIYal0I9bfTkCEE8+Kx1GF5/SjdJyz5XJNiYqBTbM5tsvR7Omzd4gM3KRqMQJ5QNpPqBiyNd4g/D8TncTX/MK8tsuq4sA06p3QtQcfyhYwXXhD1aq76EawmT/Gh8fksIR7JoKOR71TW5S1/mGvhVmXq1WsqEEyxM3mfNPBlTgVTi02gquPvIZEDuKDWkvlCHkUy+Z9eYG2+0cJTSFD3CFrLpIbKchm/1Yu+roXkU3wTE4iSGjZgkTlbyqHgXCoHnyrVoqjIomuhYyOy2L9fJipvuGLNIphj4IQDBB46vwOa/XpHiJIVtEaUu3XUYv09xY+4Ck2JLPp9KTqGgmGP/+bq91ui/Qas9paOjxDo0YoWjwiC05MzHkNraVOEfQdMFxqSRYO4d6AQvLsel9Mi8Yb9lfU4qJZlJ1qLpDGpsWJPm4aHlJjRSfKmd2A6KreVq///wjg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pOWzESmVfM30LUd16DrlvWVAqCW9FazbJwPDQU2JfFiJzmqaQ5QyF4wzlMG6?=
 =?us-ascii?Q?NfeTLTTbuMm5MFzlfGAa8CfypAprBYQCKPBT3Eu+LX2kjD56KZxckl7h0Xqy?=
 =?us-ascii?Q?MgYGg9kykEHRaB//eZJLSmwfJ54NH+LDLcXlLK7YknxcW6TxBQ4j0H00TcnB?=
 =?us-ascii?Q?92Na9dSmsSeHr7gdL4QHQ0n0xLx9b9OTUb6llY5BfQsyTRw/8ELVvzz9neCd?=
 =?us-ascii?Q?wQV5lqEB4dbXUrIITaNecuxi6hswo2/3G43RAytjo5uiIYJxWPlL3NCSAXOA?=
 =?us-ascii?Q?tmHFeFPHP4zQqPaFYrd8P25X+JdMsbRWMD/GWM6y9cgDyL4tWn5piAGSwzns?=
 =?us-ascii?Q?p4T2Aolo046gfbmaeheCAYHt0x+oOd3C+6NVDm5jq7M4HyVZAuREXqo67m3P?=
 =?us-ascii?Q?9pyMsV89WeVil2b/g4DATGimEWF/aN60/VZkQHtz1HZxfu/sljxUjfB+0baa?=
 =?us-ascii?Q?fHhuX+xGqUNMbsAhPlTNrhgzazLFZItFHSn1TzETE5O1PP+XYxhcY5anAN+H?=
 =?us-ascii?Q?2/d+hpWynY4nA+WtEEJKTL9WvKt2KcQjlYI2r6qBbqNcJGSeFUQqiyWG7EGx?=
 =?us-ascii?Q?SGEajfbo7y/nebEnZSC/wvl+01YZOnpkPBFyHmIxm33Q4nqTySPl0+FjJFpI?=
 =?us-ascii?Q?rkYflhoiNAWmrRjt8q4X4PpETzRql6dvuYrEnU5pCHp+Yuf5n6II68tcvINx?=
 =?us-ascii?Q?xoAyr1oafiLBnCp6cZA8DSB6DjWDedy4YkDiq5gBQN685Q+fk0m3v+1Si7la?=
 =?us-ascii?Q?3bH3acoXhaaDK21CO6r8jUClmhwyhovNjfP46qtce6zs2l+Px02KiXXIGzb3?=
 =?us-ascii?Q?V2uYvyo30HwS+/VKMgZGOnQZwA4heb9jc3xyfGhXzdruKDFkQSBweJfqVbso?=
 =?us-ascii?Q?eiI0vVRWCz/7ME0resbi4a2S4uwM6+YeTXPsK6VuOHWCPTPRmjHNSBbpQH1B?=
 =?us-ascii?Q?HDnlsltlhX6+HqCDsiJIexAT5BdGM0tc6xXU18IoFCBNl+qP7Z/whOg5HbH8?=
 =?us-ascii?Q?carMC/iGWr5zeKDQT55uLPSSUjis4LwuVSIFOHXYee57JKxlODituVfPh4to?=
 =?us-ascii?Q?gToJDy04y55ZLvHlCfnQvsYhZdKD6GSLvydOgyvACw2ZrSp3nreCdBgYcdl2?=
 =?us-ascii?Q?7WKKDIxeaZYeXV9SNpTpLl2qIRkpDnXzcGQxugJtbbfCrAkSB4gDAuxJPW3R?=
 =?us-ascii?Q?wbYBNuNUL9vK2Qr/6f8a6a36Qg0H0y9NNJKkU8UItxN+o1aSeYBfTaeBaLuu?=
 =?us-ascii?Q?ZzL8mCv3GTCbvO+noFdU8dSBxiU3ZIFHZubQeLJCakmT+3JPk0stQOS1d+ls?=
 =?us-ascii?Q?J6g17XCkTie7ngFugk5Mgvy9gp1OiXtA+BPA1xTxqJR8Lv3aZcyHp7VrAS2u?=
 =?us-ascii?Q?wCYjYkD40EVKClV8e4DJ6x4csuZlZ5XwlIuW6+3njeoRL6ggXHdNMOOT0rW2?=
 =?us-ascii?Q?EjOyDSBeo9PhQDVNUAJg0/6jSnca1PJnByxs0zuYV9xdicT98gVLgPm+iO/J?=
 =?us-ascii?Q?LiYTvaaFdQNkfMkF/+cxaq1oYRhoeCGBeljVg9jtiSP103hNGLSekeQv99n0?=
 =?us-ascii?Q?CbC5pgXml+mY487UBvfUOMvefk0rqhp8mWBPmwfhSubc4/xDOmQ7TMoJhZzP?=
 =?us-ascii?Q?jemYamcljQS8PV/SIKl9eIlsohgCULIpHLdoPsAp7KNXK82L2Xa1moORVOM2?=
 =?us-ascii?Q?oPO1N/RPwSsW4/ZnzbisghLZTQlL/bwMo2Qr+BUvmXliRplRoc/fsPFD4oa7?=
 =?us-ascii?Q?DIq03OCYEw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3484a9-221e-45f4-766e-08def16d3404
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:40:46.4046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7Zi+E6MlSguIRVv9QBu0ymET6CtSoMFA2PACSOVhFwZvYNuTp7IMrvA4brluCl1hC6okAa2jlnkslndNZhI1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292

On Mon, Aug 03, 2026 at 07:30:00AM +0800, Dave Jiang wrote:
> 
> 
> On 8/2/26 10:57 PM, Richard Cheng wrote:
> > On Fri, Jul 31, 2026 at 04:28:23PM +0800, Dave Jiang wrote:
> >> cxl_pmu_probe() rejects the PMU when info->msi_vec <= 0, but that field
> >> holds the MSI/MSI-X message number the device signals overflow on. The
> >> field is 0-based, and -1 means no interrupt support. Message number 0 is
> >> valid and pci_irq_vector() takes a 0-based index, so a compliant device
> >> signalling on the first vector fails to probe.
> >>
> >> Reject only the no-interrupt case, matching how the CXL mailbox and event
> >> interrupts handle it.
> >>
> >> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> >> Reported-by: sashiko-bot@kernel.org
> >> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> >> Assisted-by: Claude:claude-opus-4-8
> >> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> >> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >> v3:
> >> - Rebase on the preceding patch, so this tests info->msi_vec rather than
> >>   info->irq. The fix is unchanged and the hunk is still one line.
> >> - Not guarding against pci_irq_vector()'s INTx fallback for vector 0, which
> >>   it returns when neither MSI nor MSI-X is enabled. A v3 draft added a
> >>   pci_dev_msi_enabled() check for that, but a modern CXL device wiring up
> >>   INTx is not a realistic prospect, and the consequence otherwise is a PMU
> >>   that counts nothing rather than anything unsafe. Left alone to keep this
> >>   a one-liner.
> >> ---
> >>  drivers/perf/cxl_pmu.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> >> index 56e6ae7bebf7..c9e30cb149df 100644
> >> --- a/drivers/perf/cxl_pmu.c
> >> +++ b/drivers/perf/cxl_pmu.c
> >> @@ -875,7 +875,7 @@ static int cxl_pmu_probe(struct device *dev)
> >>  		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
> >>  	};
> >>  
> >> -	if (info->msi_vec <= 0)
> >> +	if (info->msi_vec < 0)
> >>  		return -EINVAL;
> >>
> > 
> > Hi Dave,
> > 
> > I agree that 0 is a legal message number, but do we need to check whether
> > MSI is actually enabled ?
> 
> I actually dropped the check and added notes so sashiko doesn't freak out. I don't think it's necessary given there's not likely to have devices with INTX support.
>

I see, agree then.
 
> 
> > 
> > something like
> > """
> > if (info->msi_vec < 0 || (!pdev->msi_enabled && !pdev->msix_enabled))
> >     return -EINVAL;
> > """
> 
> I can add that if you still think it's needed. The one thing I can think of is someone pass in no_msi at the kernel commandline.  
> 

Ack on this, let's not add dead braches here.

Acked-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng.

> > 
> > Best regards,
> > Richard Cheng
> > 
> > 
> > 
> > 
> >>  	rc = pci_irq_vector(pdev, info->msi_vec);
> >> -- 
> >> 2.55.0
> >>
> >>
> 
