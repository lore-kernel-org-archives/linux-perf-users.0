Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE929345D
	for <linux-perf-users@vger.kernel.org>; Tue,  6 May 2025 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746510009; cv=fail; b=qmg86IQA4NcvABA3xi787Ym7L4DjS6FmZmrvFTqzKUlz/vtUjAJDY/817mX4pgX5kUQG4Efy4/ajKlKOLZAQWv+6h1H7/3ZxmL6SLPEqrnDk8VncpTsSmccsaZub5jS7tGlShdDwdzA0gFmuFtsApzXJTvAdt/enBY8i4ywQBuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746510009; c=relaxed/simple;
	bh=wSrm7TYugFF6RU7Z8ENJNGjLt8bFZcZ06FkDMYlbPj8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UAG8iHHNdJze8WJwRu0ej8QZWHDXvkmcLRyRcIhbu60RmckafpMa0tR/vS7vmPd/qw2s6pjtNHMnl7WnR0nvHXo0e1jsEqQzlHZ4ZcaSWJ7UdObPBiMQ0xG4A4EPG62c5uaGRgM+9E5wNrxClcdp+CRLwfvj8HFM4TCIXrNTTmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6WNG9Ob; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6WNG9Ob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746510008; x=1778046008;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wSrm7TYugFF6RU7Z8ENJNGjLt8bFZcZ06FkDMYlbPj8=;
  b=F6WNG9ObmQ2SXh8VXiqbadZOqcg3ZUeJ3Skdyfnb5RvuuHuPwdPVyyhr
   //F9Jt6IeDYJTU8uec77Zb7JhmRRX/gBx5n0osw2vhTDCHiTfuDtWO9VR
   A5GIAHHM+h/3NNMOJkwZjd10jdEnh+P7nNaCb054laYV0CYDHkDq2RK5y
   d5UMK7sMkSSFRVOI8EYNCtE5DC6Gw4yc8m5sckobwa9jYh8F1knLfyaPa
   A+QiaCvFQEPjAf9/uasv9ziqxLe4hOXMCwT+udGS8hK0AKP1jvb3Cwi0Q
   7+GsXGSqLSp8qglmm/+4tmnBB2RuJkf14tb4Dxa51PF8S0J5gG7ppt4I1
   g==;
X-CSE-ConnectionGUID: qkBsswwZRB+7xSA4S+KHTQ==
X-CSE-MsgGUID: 2HJJfW5ESrGTABVj5dMrsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="73549956"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="73549956"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 22:40:07 -0700
X-CSE-ConnectionGUID: pprOhAnfTmu0YW4f6VIjJg==
X-CSE-MsgGUID: mntxGkwjR82sU2EQkWwdyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="135401809"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 22:40:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 22:40:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 5 May 2025 22:40:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 5 May 2025 22:40:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gf7T5ORBSl82WzPYEKas1xIeD0IHwnI0c8M4kTTXBs6W1SYYbUSR1Y2a9wIZogZgqWRdNOxRqAviL6hPZ3G5ddiCFKXuzZqb+j+/D57LJ+0B4c8G1ihtAcN6h2tA3KUXUiiA6UpSsOWblZCkdPmrzbFPgUTp3XOOPYF+Cegw0lnADDxfcmED9o8DZYN985Zoh8ns+R6tWst7XxNSBLuphLBvoQQAYDV+LeELs58rNpkxMS9lev9R6ZGozn0jvhsP+ASkZpGMazKQr5P5jb0p+1pEzOfvKODHEkK86jBGTmgf2x9dTwapexR1SuELARDeYFgCmmvkoz2sQEw6w1QkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NnvHQEpVAVHaK4re8ePydD5o5ifauBtOU76psCpFYU=;
 b=PyWBXlVZmYfPe4AAf9W1LT7ODH/BFpd4xBUTwKIhjzQkk2xnkQf0xLLWQqoMW7lBoCt/6j8APLE0SbhKnb4tUBZMPslz1ZnK/zR7OKBjBc9HEcOtLuC2N69h2u9qzKrB3xcYgrndcYxORZ29IRDQSbBvMC93lz3mpx6ZamUED5bGK1nx7l6wwSx6TfOTpmQIcyCSR+NKGLXTEbTpy8tDSap0B1id0DdwlXUeDo855+UhVvUsNsCH/vI+uSe0ywOZBFho9ev4p2j6Z8nRG7UD5eEELbIbgn/yxwi77mJ6u0xugE7btGC4MYUt+OEwVnwgwFBJ+wBw5FOcSH6j4gj5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by SJ0PR11MB4879.namprd11.prod.outlook.com (2603:10b6:a03:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 05:39:59 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%2]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 05:39:59 +0000
Message-ID: <2788a318-c4e6-4acf-91f4-29a3ca4b3bb6@intel.com>
Date: Tue, 6 May 2025 08:39:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf script: perf script tests fails with segfault
To: Aditya Bodkhe <adityab1@linux.ibm.com>, <linux-perf-users@vger.kernel.org>
CC: Aditya Bodkhe <aditya.b1@linux.ibm.com>, Disha Goel
	<disgoel@linux.ibm.com>, Ian Rogers <irogers@google.com>
References: <20250429065132.36839-1-adityab1@linux.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250429065132.36839-1-adityab1@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0040.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::17) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|SJ0PR11MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: b26ce5a4-a4fd-4b9e-88d3-08dd8c607095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2NMY0Z3THl0ZmIyNDhFRHF0ekJmVjRHMVlPYU1HS0RPdzF4MFZMa1pPNm1B?=
 =?utf-8?B?WHRUb2NhOWpxNW9NVFd1RkNibDZKL2dFb2Q2UFZWY0V0R0lDRWF5K2VQcnVK?=
 =?utf-8?B?TnVMQXNaa0kySWFSZUIzWjdnSHJiU2RYUiszV3ZlVEhnQUFtMEJhSkQxQ25F?=
 =?utf-8?B?bC9UQUhDTEEyNGpGZE1RRmhoSTI3a2ZxT1dWMWxRK2VrMVR0WWVlamJpS2c1?=
 =?utf-8?B?U0tFOFJGc1FKR2J4UUhDM2Vqc3Q5SFo2ZzVPdldoL2xzd2JyUnRHRmVDR1Bn?=
 =?utf-8?B?ZUpOMFVSRmI2eTlkZmdQcG40TjFQTC9hVkhGSm54MTRZb3NBSi8yTzBKdkpO?=
 =?utf-8?B?ajVtKzBKWEFRKzN0N0VwVXdBUG41N1FsT0JjbzFFWlVxMHZ5ZVR2TmZmQWNW?=
 =?utf-8?B?REhNcHJiUFAvbDV4V3ZnQ0YvTDhPY3ptYnhNTDNsMDVyR3hXb0FsU2lBNkJy?=
 =?utf-8?B?eElvN0s3Q3RtYzlBK3ZHenVPZXBrb0ZBL2pXRDkrakd3WXpkamliUnV2bGNj?=
 =?utf-8?B?a3ViV0pNa0RPZVQ1WU5McmNHVHpjYllsMEpYYlhQc1gva3YwQVVYQkZFYkZR?=
 =?utf-8?B?K1NWTDhudmNhUDYxN0REN2VqR0pNeU9zdVg1UHRLUFZ3OEYxSytDem5SL2ty?=
 =?utf-8?B?MjVxZ0hQVEJ3UTRlTml4My9NcC9WOVpJZHRSM2xZemc5SVM2bkRreE1UbTFK?=
 =?utf-8?B?dEtjeC80RVdQeGRTcm9xOGRCSGlyRVBMMmF6eVNNOWFUQ1Vyc29hemdpRVBM?=
 =?utf-8?B?bUN0NUpkWVorM0R3NmZQNlF2dXJEbTdReEhER2NxRHAwMkxMSkZ1Z0dQUHhI?=
 =?utf-8?B?dktoZ0ZXL3ArbTJ3V1EyWUdNdGVsQzNoWFNkWjdMaksxekpibjRLdFN5OWls?=
 =?utf-8?B?Um5teWhUMkJpcFpmSVl6VnljN1VOL0lXdnJnQVcranREUEZKRzVhL3hQRmEr?=
 =?utf-8?B?RTEvOTNyQUhCRjdqK0N1dzcwSTREUGZIcFlLaktuVDlTZENyZExTdEV6NTN6?=
 =?utf-8?B?bWlPNEdjbGpFSit3V0R4WXRldS9sNGRScXk4NGdwRXVVRWwyU3FIL1dxMGxB?=
 =?utf-8?B?YzFjRXhzd0RTWEx6ZEhZY3VQcXFhbURyaU1KMHdWdzZUUnRDaWFUemdBRUhz?=
 =?utf-8?B?NTZHRlhKK3Y5elA3VzVXd2h0bUhmWDJKQmxod08xbXlnT3I3c1ZJUHVFeWlp?=
 =?utf-8?B?UDUydmZXQU42U3lxVDBRclQrMzYvZkNIMTFkenFGK2JvZzVibjBRU0JnaVh3?=
 =?utf-8?B?YmZrRG1Mc0ZDN0Z3amZSaitnQUJEU2p3VmtweHVoOUFtczdUNkZLODJVNEdW?=
 =?utf-8?B?ZktpTFpRVU1yVHo0bVFsU2l4a0ZiekVVRFY0OFB1TXBSRXhxMG9zSEdxREpZ?=
 =?utf-8?B?R25OazRKSWhIcnVBZFVkbHpoeDFvR0ZjR2NGNnpVK3JBeHErQitlNFN1K21l?=
 =?utf-8?B?c0Jyd0V2THdGd215TTd3MWI1VmxmMVM5QUJpYWdJNXF3WTQ1TWllSmRkY3li?=
 =?utf-8?B?TTY5Ylh5a2ZXdVRmVFpMeURCZ1pFaWpweEdqaW5OVmJ2K1lGKzRvRVBweFpQ?=
 =?utf-8?B?b3ZqWDJKalA5RGNPY2dwOFczaUdpS0E0alErWVgya00wVitFWWp4dXNNenZw?=
 =?utf-8?B?TFpUVmhqWmxwNVpVRlo3YnA0UWtVVHcrRmZweWZrSFdaeTNMcUI3OFBXelQv?=
 =?utf-8?B?N1dwYVd5RjVaVzNDcGdJMng3V2JxTHBhUlZtcGtUUk9kWHJTcG1rdHJzZlNu?=
 =?utf-8?B?bGJlYmJQTzFSbTFRdlY2bFhPNlRLUldlbGltdU9GcnZIa3ZHR3NoUWJ2YWZK?=
 =?utf-8?B?M29tUnhNK01CS1VmL0tQYkpRNjVDUmticDVDSjMrbUdrYzJObGtPalFDa1lX?=
 =?utf-8?B?eWZVejhmUE1JR3dyT1VQTlAzOXNvc1pjSHNDSEpxTHl3U3lVWENsWWNIVkhx?=
 =?utf-8?Q?3TetC3a7UfQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDg4amx0eG1SSXl5b01leHcxbmNwOG1xZitPb09QVW9sY1BuNUJ0Zlh2aVNN?=
 =?utf-8?B?dmwvZzI0Q2czRlRoV3JZem9SWXZDVDRMbGM3R3NTMkFUNHdHZzQ4TVhhVkFv?=
 =?utf-8?B?S3FmZnFGTDd6anRBT1lUOFphamozeHhkMVlHT0g2cFU2dEtVUTBvYUFQbU44?=
 =?utf-8?B?Y213N3hKVWs5aFRKSmVCNFQ2SVcvQkNVN3I5cXkxVG9BeW44dUpCdmpKZ3By?=
 =?utf-8?B?bU5pblY2dXVmNUsyY2V3aEdDNXVPeXEyRWlJSjY4NTI3U1RwdWdvMDdyUE1C?=
 =?utf-8?B?WHJCRFFPZDIvZWpvRk1kS2kvVzhvbExDeEhwOGdHSmxpdEZhSlVIUjAwWlRZ?=
 =?utf-8?B?T1hINkJJYnlnSTlacTNranpXS096QnBOM3pvZ0hwczNJR1dDZUJKbXU2cmZ6?=
 =?utf-8?B?RGJPbm9iVGZEVWI4QmhHOEQwencxVDVjNVVQS3pNRkFJeE9tUXduM1hIY09i?=
 =?utf-8?B?R3QzRWN2NCsxeDlrSldNOVlEV1ltZzdvT014VHhoS2drbDM0UHVuWjg4c3Z1?=
 =?utf-8?B?bURDSWhmbGdUbXNhbWpDTlVYZHhyUnluL1R1VDNRT0pzdzhzb3YzSHlicUlO?=
 =?utf-8?B?WU42VEdoWGtnb1lDY2F5anJoQ1JOYlFHQUFNWlFtWXEvZlZQK3ZRbEZHWGpP?=
 =?utf-8?B?WFRvTjl0SkdaZGVyMjBjb3R3SDE2M3VVdVA4MUZHdTFUeXplY1lTRjhXZklG?=
 =?utf-8?B?Vk9IQmt4OFZ4ODdrKzJta25VbVpOMlRhTks4QTg1eUcxUjg0OFA1UnBUWWZH?=
 =?utf-8?B?WkI4NTZFdFZTd3FjVkhOaHNmM2psTmdNVTAzelY3S2pVamFxb011Z2Y1ZFR1?=
 =?utf-8?B?YUpLTkFoM3d3cDlLQWFGZTlzRzFyL3JCZ01pQmozczF4SDVUd21PNXZ2aTEx?=
 =?utf-8?B?SllPR0I4bFhrRWxmdVFWck9XT3RkQ0ZoU292S1RzbGtvY2diSjdRZTd0VHhm?=
 =?utf-8?B?M1Vlc09YWmhyUFlFWm1idS9tRjRwbFJrQy9pVlQ3ZmprL0c0NmxLU2Q2OUdB?=
 =?utf-8?B?TzhUUWUxY3ZsM2x5U0RROVBVY0hKL3NBZmhEemkwRW5raHdOKzJyclVJMjdW?=
 =?utf-8?B?UHRKNW1ETXA2ZVdTZFFpeTVGMkRhRGJJaHRFcS9hU3RYV0MzOXFaQVdnQ09M?=
 =?utf-8?B?YkJYdGhQQmN5ejhHQVpsOGx3ay9ONEVZeWhONU1YM2lVMFIrK01DZEZIamlZ?=
 =?utf-8?B?VzlhZ2hpRFh5WHF4ZHAwdVFMRFZyTS83OS90UTdkWG9KSlFURndSSGd3M1VO?=
 =?utf-8?B?YkdqdjJUQmtWVlpkdTRYTUVoZE1zTXdpb1JvcDY0bXVtZnU5T1BtL1grREpV?=
 =?utf-8?B?SUJZSDd6ekczaEhIZml0WTR4MWpoVHlyYmJqYmNOOVFINTlDU2FJSW1Rc2VY?=
 =?utf-8?B?Sks1Ym5FanBsY21tRTd4dDc5aGdidVpEUnRuRnBoRTk0TGlhS3BEN1FiWmlz?=
 =?utf-8?B?RnRNczZxeDJLa3A1eW9LUzRZWjlzL1FnMnM3WVdwVnpXdkpMVTdxRXIzRUxU?=
 =?utf-8?B?UUxmUnA5ZElmVWpJdm5vTERPb3FnaWN1K0pDN2FjWXN2VUlxV2p0Kzd2TkZ1?=
 =?utf-8?B?N09BR2NCQ2QzSEFHSnI3UkR4UnVBUldmbkxIWU1PczFqaEpFOTFsNFFBdm9q?=
 =?utf-8?B?bm9vWWNQMWNzS3dsWUE5bGthZ0FFUkQyWCt0Uk5obUIzRnVCTDRsdkgxeXFR?=
 =?utf-8?B?eDZJdHFxTVBRaFlkcjNZRDVZanJCeEZEL052Vzhsb3ZRaWp3T280SGorTStU?=
 =?utf-8?B?eURobmlNT2dobW41VnFKQmFDQzFZekFlYjdzMVUwclRPMDVzZGxXUUkvTyti?=
 =?utf-8?B?OHNvcUJlVmx1MFBXeDloeHk2K0RQTjFUVll1bXIzdTdiOE1JTkhWODNFcExy?=
 =?utf-8?B?T3k4U1RwdWUzKzRpN2tIUjg2eXp6STU5dWRZN21zL24vVEl6M3Fka3FCekxm?=
 =?utf-8?B?QnVML1R4OTNZTXNKOXlEQ0JrZUo4ZkZzUDMxa2hRUDBPakJqZHgyaTU2Ym5X?=
 =?utf-8?B?ZUZhM2ZnRnorWGFxRnBVYVQ1NTI4cFc3YzRCd3FKSmxJbWdQOEFPWEhwdE9l?=
 =?utf-8?B?d3N4cldzejBoUDVQWEEyV2U5YkUxNG1PRFhxUjZOckVBN1duZXFuUnJVbkhI?=
 =?utf-8?B?QmlZWVQ1cVJPK3hZaXZQRm05bHRDM00wTTdndDgwQmNqTmtuWGdIak1QZmFk?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b26ce5a4-a4fd-4b9e-88d3-08dd8c607095
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 05:39:59.2402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVe6+j83yJ0BQDrCOsjKOpGPtMLNY+htq9eHSVuqla90514+Tzb5rEuwaMrdHUY7a27WFSGDX/tDX8LX4wUv2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4879
X-OriginatorOrg: intel.com

On 29/04/2025 09:51, Aditya Bodkhe wrote:
> From: Aditya Bodkhe <aditya.b1@linux.ibm.com>
> 
> perf script: pert script tests fails with segmentation fault as below:
> 
>  92: perf script tests:
>  --- start ---
> test child forked, pid 103769
> DB test
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.012 MB /tmp/perf-test-script.7rbftEpOzX/perf.data (9 samples) ]
> /usr/libexec/perf-core/tests/shell/script.sh: line 35: 103780 Segmentation fault      (core dumped) perf script -i "${perfdatafile}" -s "${db_test}"
>  --- Cleaning up ---
>  ---- end(-1) ----
> 	92: perf script tests                                               : FAILED!
> 
> Backtrace pointed to :
> 	#0  0x0000000010247dd0 in maps.machine ()
> 	#1  0x00000000101d178c in db_export.sample ()
> 	#2  0x00000000103412c8 in python_process_event ()
> 	#3  0x000000001004eb28 in process_sample_event ()
> 	#4  0x000000001024fcd0 in machines.deliver_event ()
> 	#5  0x000000001025005c in perf_session.deliver_event ()
> 	#6  0x00000000102568b0 in __ordered_events__flush.part.0 ()
> 	#7  0x0000000010251618 in perf_session.process_events ()
> 	#8  0x0000000010053620 in cmd_script ()
> 	#9  0x00000000100b5a28 in run_builtin ()
> 	#10 0x00000000100b5f94 in handle_internal_command ()
> 	#11 0x0000000010011114 in main ()
> 
> Further investigation reveals that this occurs in the `perf script tests`,
> because it uses `db_test.py` script. This script sets `perf_db_export_mode = True`.
> 
> With `perf_db_export_mode` enabled, if a sample originates from a hypervisor,
> perf doesn't set maps for "[H]" sample in the code. Consequently, `al->maps` remains NULL
> when `maps__machine(al->maps)` is called from `db_export__sample`.
> 
> As al->maps can be NULL in case of Hypervisor samples , use thread->maps
> because even for Hypervisor sample, machine should exist.
> If we don't have machine for some reason, return -1 to avoid segmentation fault.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>

Ian suggested adding a helper but this fix is fine for now.
Anyone inclined could add the helper as a separate tidy-up patch.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changelog:
> v2 -> v3:
> This patch contains changes suggested by Adrian Hunter<adrian.hunter@intel.com> to add extra spaces
> before ---start--- and ---end---
> to be able to apply patch without any issues
> 
> v1 -> v2:
> The below patch contains changes suggested by Adrian Hunter<adrian.hunter@intel.com> to handle the segmentation fault ,
> as well as initialisation of al.thread
> 
>  tools/perf/util/db-export.c                           | 11 ++++++++---
>  .../perf/util/scripting-engines/trace-event-python.c  |  2 +-
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
> index 50f916374d87..8f52e8cefcf3 100644
> --- a/tools/perf/util/db-export.c
> +++ b/tools/perf/util/db-export.c
> @@ -181,7 +181,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
>  	if (al->map) {
>  		struct dso *dso = map__dso(al->map);
> 
> -		err = db_export__dso(dbe, dso, maps__machine(al->maps));
> +		err = db_export__dso(dbe, dso, maps__machine(thread__maps(al->thread)));
>  		if (err)
>  			return err;
>  		*dso_db_id = dso__db_id(dso);
> @@ -256,6 +256,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
>  		al.map = map__get(node->ms.map);
>  		al.maps = maps__get(thread__maps(thread));
>  		al.addr = node->ip;
> +		al.thread = thread__get(thread);
> 
>  		if (al.map && !al.sym)
>  			al.sym = dso__find_symbol(map__dso(al.map), al.addr);
> @@ -358,14 +359,18 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
>  	};
>  	struct thread *main_thread;
>  	struct comm *comm = NULL;
> -	struct machine *machine;
> +	struct machine *machine = NULL;
>  	int err;
> 
> +	if (thread__maps(thread))
> +		machine = maps__machine(thread__maps(thread));
> +	if (!machine)
> +		return -1;
> +
>  	err = db_export__evsel(dbe, evsel);
>  	if (err)
>  		return err;
> 
> -	machine = maps__machine(al->maps);
>  	err = db_export__machine(dbe, machine);
>  	if (err)
>  		return err;
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 520729e78965..00f2c6c5114d 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -1306,7 +1306,7 @@ static void python_export_sample_table(struct db_export *dbe,
> 
>  	tuple_set_d64(t, 0, es->db_id);
>  	tuple_set_d64(t, 1, es->evsel->db_id);
> -	tuple_set_d64(t, 2, maps__machine(es->al->maps)->db_id);
> +	tuple_set_d64(t, 2, maps__machine(thread__maps(es->al->thread))->db_id);
>  	tuple_set_d64(t, 3, thread__db_id(es->al->thread));
>  	tuple_set_d64(t, 4, es->comm_db_id);
>  	tuple_set_d64(t, 5, es->dso_db_id);
> --
> 2.43.0
> 
> 

