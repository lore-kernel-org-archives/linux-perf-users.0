Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4301EF39E;
	Thu, 30 Oct 2025 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835663; cv=fail; b=Z8ZJQ5yLTJGYY3KGNLonuuyQwsTNyutoxpFDCDkLG8+0G4CywCAGS8BnY1jZo0Zh0cWjPNbsT4Ta4Ev4MhDFcUDVwREJSD/iWUKcmcOedAtZS6/r89qbGU+WThmniaz+9xuRDmvBujEt00JRN6jKk1S9NPD00mCKcQqG9tVrxC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835663; c=relaxed/simple;
	bh=nWC76DPwjQ9lD8evfo0m1fZ1eEGs7d3r3NbgKlzvHpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=jZ6TF3pBt4TRUSvmV60H4E6hWy2imhA6DYgMLTEG+Y0WmkXok3glHpGA/P6IISdTviREPCOTeDEDWyxXrLxcVsHQEsGHfHVYqzVIJp7ioIfsLK+HCn4xBiUSJQyczBnrQErP2Bu99XHrDfkxWp33myNZnFY8rCcwF/W7ggcdiuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E6suew5d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JtY5+I3H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E6suew5d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JtY5+I3H"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UEgMg0009395;
	Thu, 30 Oct 2025 14:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=x7Sh67DkEBeSlHL4JTFovddNr6RftzvwM008KHnQh+o=; b=
	E6suew5dJg2eEuFJVyinGN0iHcx7TbZR451fxLW6Xft54vsubr7TMNjd9PReCr6n
	UJ8x7GLce0krO9sfT+cy9F1KUY3MgLKAPiHOrneKIkEB5sev3XNIsLGekxhHW9+8
	HMN3pgrSSJf9p+zDsye/VSpEDLQBKaStjw+GPWHF5iyJyBUj9gkVJJp0cIaQWsei
	+e6ROnuGaRHMJpxmhAJw008tV3I1DVRpnD378HTiKOMj+te0IeqbdYjTg6PnHsR/
	uaugX8QCVR6004pfNb6Q2PZUa/SfzjDrRE7y1/AZi2Odz/MMbo8+vvR/jTGtqN/b
	6V5HcmbWRRi6hTzfydlBKg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a49yn80mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 14:47:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UCxoH1017358;
	Thu, 30 Oct 2025 14:47:36 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013022.outbound.protection.outlook.com [40.93.201.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33y0qn3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 14:47:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EC9IslQ6qwrpwulXIACVWLO6L/AYolN1q4PZYJiErUhtv+eNC5vpJjWn7iXqDFM9hFZxhbhoeMe51+xq9XWdNLRr274XK3qEQRORoUQuo4P4t2wGDEpRy8rIskGVt8F28omNTGJooiteCP/GmHsABHv4r51ne8aqTW1Xu66g30OWj2xPT24Kk5biV8xvhTComq2P4D4T20IhK/x6XuYIGFNDEBe+/dfIFkXPQXtnQ6qG2s49Kb6+ItHkO/I8jae0o4cjPS4r/rLKvgf5MoC14N+9KFGZXgnCNUAV6Nws18icWxPBlca+u27ElQVuGEJ1M6D3LH1EDIwuyoERtMXMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7Sh67DkEBeSlHL4JTFovddNr6RftzvwM008KHnQh+o=;
 b=xgyScgw7FD9mupAxGb8I58409AJotM/vyf1eZLGKVpMZE18e8Wxa4/82EuUjON7lPYTAPeRp+55BDtqo2NJxH8qqLGIp25Vvmo+LybxNTgDYYrcRaRl0qrOG0YMB6VoL41gG5YCg9lwXmIdfhOJmKsKF9CSZvuBfpOx2HPIihJYu1m+1/CQpl45xdBVXOpqnAwA1jBZ9Ww/7mKmjnjbTkhUxPdNnyIFe5hVbsWklS3oDQrtlWaAoCxa56JBmEFGD68Ch7qri58j94K3kjVR251+uMQnNFzlirfx4bpJJG/WgnEQTn7lAGiMhL5FIfOtaJEekATc9uVGPA3VCYBBJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7Sh67DkEBeSlHL4JTFovddNr6RftzvwM008KHnQh+o=;
 b=JtY5+I3HkVDDeojxbvc3k8+MmSRw0tHtTB0zjOvQCybyhWJ8zqgrFik58eUKcSGPTthkAEr2WCU4Oywjq6EZxMuIujuHXNc+fjnzCAzZ8iibYVLAdXkCPTSub9zzSwEPUXOt2LuJEnsNbgrg7XiQy8gjQAxx12bT5MlwnV+Ax8Q=
Received: from CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 14:47:32 +0000
Received: from CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc]) by CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::8a:149b:1a7a:c7dc%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 14:47:32 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Fangrui Song <maskray@sourceware.org>
Cc: <linux-toolchains@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Concerns about SFrame viability for userspace stack walking
In-Reply-To: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
Date: Thu, 30 Oct 2025 15:47:28 +0100
Message-ID: <87h5vg5tvj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:EE_|SA2PR10MB4508:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a59722-2b74-45d1-2cbd-08de17c341f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3BNZmpYTFI2QjRkZlVkZnpMa2dNb3oxMnd1TVlJOHc4SUhwTXV0V2Y2cCth?=
 =?utf-8?B?K0M3V0ZDdDRwa0habUd3UUhSVEU1RnBXSG50ZC9CZ2RUR2RwL1dWVkwzMXFT?=
 =?utf-8?B?YjhEV29YZkNxR0QyUlpGQkUyQjA1Sk5mRzVUamQ4RG44WCtXVElHQzJDeE5E?=
 =?utf-8?B?MkhIZi9vMWV2RVd2dFovc285ZlRqY1dJN2tURm1GNzFtR294NnBWcEpsemEx?=
 =?utf-8?B?ekNvd2FxYTh5MTFCaHNybGdhcTQ0eWNWV3YrNHMwNXU1WDBqVElJaHcwQ0JR?=
 =?utf-8?B?d0M1ZC9LLzNhTG5yakdZRUdkeEsydVJPNGIwQWp3dHlCWVVpaUxHMlh3OHV0?=
 =?utf-8?B?N1J3c0R4ZTlMQk5ScTV3MVFBaERCMStEeFprSFo5Z0lLMC9tSmhxNTRwdzVm?=
 =?utf-8?B?Y2RKdUVEbktIVFVpMkpoWlZtK0tUaTBIRXZRaDBrK05FSlp5YjJSUk5FTEVJ?=
 =?utf-8?B?RjFrbkh5eDltV3dUM0JYRHBDZHZXWlQ0RXNaQUJPR1ZuSm1Md0lsNGUzRDk2?=
 =?utf-8?B?bmUyUDZna2tlcEFiZXpqdDRjeTBDeUR1UHg3THJ3ZWhTUE9BTFVFT0N1L2R4?=
 =?utf-8?B?aTJOQWFVbnpjOHpiVUN0TXZmRGo2VnBCQm9uSVoxMFk0NldIUUt3ZVI5UE5T?=
 =?utf-8?B?d2laeHFVdG9WMmZUNjMvUmRENFZnSEJHQVcycGwvd1djNXBqOVFPQzR5UXBI?=
 =?utf-8?B?Rm5Ya0Ewekc3Z3picFlwWDVKWGxuNDlqTXd3UlBWNXpUSXQrUm9IdnpRVVl5?=
 =?utf-8?B?TEk4TWFjeTFMOExkME1Md2o0eVlWWWhmL1dYREhDWDRjRlQ3d2VtRjBuV3Rh?=
 =?utf-8?B?YkdCQm1LV1RBOVNiSVhYYjVUMkpRYXFycHREZnFhNEw3T3NHV28rbHhlM2Rw?=
 =?utf-8?B?MDhZekEyTXVNUzd2bUFSazR4Zm01T3oxM0pLVjJXMWxZKzlveS9BdmNKaTMr?=
 =?utf-8?B?ZHFieURBUVE1NUNOQjA2WVFaaWt6cnQ1T2lOTm51MDZYejNIdGRlVVRDeTBM?=
 =?utf-8?B?SHllUFZaNkZ0Z1lHa3luOHFZZHUzbDV5bDBPVDgyUTlKUm50cEUwVnAreEJz?=
 =?utf-8?B?UkNLSkJMTVQ5Zkd3cFdkUmRQSk9tVkt0OGJ4NnIxeHlvL25xbU01M0RTbm93?=
 =?utf-8?B?MURwaGNHMTc4V2d6alBsSGMxSnFacVdTWU5lTkUwZkh1bklkRU05QUpLOWI1?=
 =?utf-8?B?dFFMcm01KzdYaTFsc3pIaURQWXN2Ykl0VTdvdlVjd2NVcnpSRFFRalBnc2ZT?=
 =?utf-8?B?eWVnbmwxUFkyQUF3ZWttK0ZOSVFPcmI0TExVU1VTc1RZaWhON25RS0RkcldV?=
 =?utf-8?B?ZVZkYk8rUWhFTjRQakZzZG9ULzY4c1l1SFo1MUptSitnNHk4WTRzWW9xcWJ5?=
 =?utf-8?B?S1lLVEEzWEFjbG16V1lMNFB6MkJZTzI5YzVsTXpON2J4ZVlVVDhUQk15R2RO?=
 =?utf-8?B?a1Awekdrb2pKekdESlBVTWVSV2JBM09JekppY01uQngzSEhNM20xN0s5TVp1?=
 =?utf-8?B?ZHJUcXNNMnlPZUY3OWRkOTlmN0IyOVloWjd1THRYT0wvRHlCTGh0cXlXYkxN?=
 =?utf-8?B?czVSd3JBeTExTmhsSytDZFVCc1gxcmNpeWoydk9wYVNaZ0JML0t0S05xVUx2?=
 =?utf-8?B?aHVRRlZydzNEQms3SG9IRDZqcWRuK1dlZnJ6UUhWeno0MlVIcmNpZjdYTTF5?=
 =?utf-8?B?RmR2eG50bGFPQjhBZ0ZhM3UrTnhvZEhRY3UzcDZ1Z3JDaWtqM3FZZFNJVUpk?=
 =?utf-8?B?bTY2cVJuZXkySElkNVUzdkE0Yk9jQTVNKytsOFRxeU0vT2VudzBzajZJZjhw?=
 =?utf-8?B?Rm5HcDFHUXNoK29OOHdpQmpST2tBY1lyNEJ3cko0dXBnZXk3aFdhUXBXOTJx?=
 =?utf-8?B?alcveEtwNWNPTHdkK01relNMZ2dTNExheGVKM2U5WE9GaHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4500.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTZ2cnhzY3VvckhsRnd3bytGZmozTWVZYzZoNjlIbTU5TjFvVm9oYVgwRGYz?=
 =?utf-8?B?UWpVYkZyR25FRFg3UUZVMkNXYlhHb0NIczR4OFpNKzdNSkhOWnlJVHdZOE8x?=
 =?utf-8?B?UVhOQXJZMi9vWUVJWXE0NWRWZjhVMkdiR0ZUaGdrUFZQa1RrNG1SKzBPTjFL?=
 =?utf-8?B?dURDRnBqRDBiZTRDR01HSFNSa0xCVHo4NEtKelRjYTBJYjVHdmd1R2c1Z1F1?=
 =?utf-8?B?MlhBdlRxdFdnbU85WnVrTTNpeU5FYWd5L2dMTi9jUjZ0ejVPUUt1d3lGdlpH?=
 =?utf-8?B?UDg0ZEV0K0VicjlLOHpuUFlyV1BNREthamY1OTBTa29NV1BTSHRwaXdNbGVO?=
 =?utf-8?B?UENubjNpWGRzVnRYckgxUnJwWUtpVWVraFNvUWJjTTlkbFFTK3oxRUplbXdv?=
 =?utf-8?B?SGhETk5KU0tUMnl3Slh0VExoOS9uR0FkeFNNWkQ5UmhwVExscFZJRmtReCt6?=
 =?utf-8?B?ZzQvWHVGSSt1WDRqUjg3V0FzQ01DNDVsU3M3eGJCbFhBVjZ1ZmhJRkh5VXVB?=
 =?utf-8?B?c043SzZmNnJFQ3BPblJVUzg3ajIxVU5ta2h0aHBjUjVmSG83RytIWmlwYlpu?=
 =?utf-8?B?cWNPaXNibTU2RTd6S2M1a0VHZVExcnk0MXBtenVacURiOUdjRkZscXFwby9X?=
 =?utf-8?B?NFlGcVkvUWdVS1JTTWJTelM0cVhRQWtFK3pRY2ZCSnpwamQyQWxGaU93My80?=
 =?utf-8?B?bkVaOHgxUlRnL3B2MUM3ajNUZ1l2RUhSVHVSUUkrUngxUnJZVzc2K1ZwRGRu?=
 =?utf-8?B?VGpVYkliR283WXlMS2pWajZuSDhIUlBoV0J0Uzc2VzkvWHhuYXRMS2lXdTdt?=
 =?utf-8?B?NUJuMzduR01mUHUyVkM1T1BiMnZDNkNRTWlQMkVWcWI1U1I1MEtLdm9RT2hE?=
 =?utf-8?B?QXlRcHZhY0ZQNjVCQzZWNXZ0YlcrNmJJVW1tVS9reHVhMVA5U0QxL0xiUHVi?=
 =?utf-8?B?TkMyN20zcERDUlFDVUloa2xVS2ZxK1NCZzRTV1g2YllIaHRVWHVWSkZTZkZa?=
 =?utf-8?B?WDdBK2IxL3lmblVPNElGUVhOM0Y0d2JFMENhUUlFWXQ4N1JsaSthVldQYXJU?=
 =?utf-8?B?QnIxYVl5Q3BvaDBpc0VIZ1pSN3dOWU80SUMwRm1uVXp0dFpqUmdHVTRMSkxF?=
 =?utf-8?B?RHQrWDI5NEszOVljM0ZsNEdiNGZndWZxMmE2R0gyUHIwYjVTc3JtaFNEaXlT?=
 =?utf-8?B?c1FKYkh3YmRLWEsxNU0wTXdjWDBneDFhdGd0QXVES0VXYklTSWV2emtjcmNj?=
 =?utf-8?B?TE9rOUc1TkJ3TG1yZUdHSW5xalBlOVdCSE85UStyV0h2WHRXRmwrdmtNeU14?=
 =?utf-8?B?TXlRS3JBaG8xVjZ0QXZNMXVjZ0JLQklTc3ZqeXg4eWFqMndBbzlwZ2RtVFRK?=
 =?utf-8?B?L0RJR2p1K00raGM0Um5HWmFLNWZLQ2N4bXVyTVIwTVRGQUJKRWVnaWlHTEl6?=
 =?utf-8?B?SlY3U3c5Z2h5c1U2c2k0UUZTTm9BYkhVQ0N5SU52OWV3THA5ekFXTWhiTm14?=
 =?utf-8?B?ODJyWE1YT00wdXB3SWtxNTZvdHVaVDR5eVZnOU9SMmdGWHkxcXdQeG1oOW9u?=
 =?utf-8?B?SW1mbVpaT2o3WWltOWt6eklEODN3d3JldXJnRkY0ZzRwQ2tmUXlEVzh3T0dM?=
 =?utf-8?B?WGR1QUo1bkdMQ0FRRzdTWnBLU0RySmMxOGNCNHltYmg1blY5ZG1NY1NuanpD?=
 =?utf-8?B?Nm1UbUthVFFobHBiQmsyT25TdmQ5b1VjUk9CTGdjVGt0OGNiQytzbGJNODUy?=
 =?utf-8?B?Ui94czBMdU1MU255Lzl2Uk1rYzA1UWtYUGxVclBjSXlYNDE2VUdObDEyRjhi?=
 =?utf-8?B?TmJwbDJBcG5HTk4waEZ2UXlBM1h0K1VEVzR4WFJleGZLaldiclE4V2NJYlFG?=
 =?utf-8?B?cFNKQm5yNE44d1VjR3FSVWN6OEdjTzN3WGl2WDRwZjdRQm5PTDBkREpuTE10?=
 =?utf-8?B?RzZiZDRGUktPbzNCQjFOWG15RFpiMDgvdnVSbHUwdnBvaWYrNytkTzlLL3ln?=
 =?utf-8?B?WXE1VUlwZXI2dTY3a2FwY0FmR0gyOWZxQzlmSDZwRFdhU3VvWVMxNkJvc1ow?=
 =?utf-8?B?bGpiVTI5NWQ5WElMaE9pZWgzRCtNYmlBQmtJZEVVQkpWRktHYk8weCt4Szd3?=
 =?utf-8?B?SnMwNnM0cENIL3dkMW9YWFVzREJkMHpKWllFd1V4N0h2dmY5U29XYnZkdnp6?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8hSpIzBpUQRrLnbx0CbMLVfTER0jaoPEm3Bl4JlgPlALf9hitY5cpTG9Rm+CBFiN1K25FMiW9crHjWoNEUygn0RSkeq498YQ53asSJy0277VbgzAPIYFfP7HZZ6AjWg2FmDGS835fnLuvky9G7TpDxG7D9A+kPkHuJUtSZ1a7yq3VGtvi527OZ6xE5jqLWRun0J7daFvE0TE8CP0ZW6zEcy8KgX0ivyN1CwvRHIQpPEjNcZjD6xxQPygEtjRVgHSsPb5bz+P4E2XwiRKkgkXJ1XvWNWAw7MFszXHykFQyORAGUG86RhK7O9tbZcRDoOJ0lDRrq55Dehl+yF/k7BXM4yyyVaATaxn0vQNm3OQ/7tzVthtyN6CqQ3VNGv1mcw2ysZhazlatHEf5kaaS3kDe7aL5Niui9OyxbpINdI/h8Y8jr3CXqVG5Pqi4vXS+KNUYj0Spxt6/+xABMq6Z3lbDSiBbYLmrfvHWe8JdaLGWw+HDVzDuSkAhovBzV8pCJjDSm4aVboRyUYEijoHUjIU5IfuajeGL0dEyXwmwuHlnTjt4Zjl8Y17aFnxNKZFsbfEA5xfCpZmO2SLtRRt3kLzRJDnki5OcgDFzbRRr7v2J4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a59722-2b74-45d1-2cbd-08de17c341f8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4500.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:47:32.7831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kc1jb7VE+Edxzg9goWAhC8t/3DXrU+0+IpPfcCBovpIDVWpETtwcXuktDSi7Zhh19G5ENp++nzYM2/eAXP5czz3KWt2OhgzqE8MOPD9D50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300120
X-Authority-Analysis: v=2.4 cv=L6AQguT8 c=1 sm=1 tr=0 ts=69037a88 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QegZ8fZzAAAA:8 a=CCpqsmhAAAAA:8 a=1XWaLZrsAAAA:8 a=vnREMb7VAAAA:8
 a=Twlkf-z8AAAA:8 a=YNk4PUJTKkDMdlYkECcA:9 a=QEXdDO2ut3YA:10 a=uLkWrTCxENYA:10
 a=_Z14B2EILkUCX44yj2ln:22 a=ul9cdbp4aOFLsgKbc677:22 a=-74SuR6ZdpOK_LpdRCUo:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
X-Proofpoint-ORIG-GUID: 9vJ3bcfUBreJRjpcxwhWBIb-c7J3Jla2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDExOSBTYWx0ZWRfX1yNEGtmVKlRY
 etW8SMlEV6iAFKur2RHF5Lohsb8vxQOoKX5qOMM0ZrWAi+KAOd0kValgMmodccz85Tnfj0FX63H
 K92KVWwbHo0F9Js+JJKifThNR9gTo3EQRfnztSVlcnfKHrRHpxnOUVM3KebylAvhubL7BlPcOiS
 koBd+4gHkCJZ3sGUohY8id6pBfg+R8nsnQlzWn/rnW7bYfcV2TZLfTq3m22g7huOwZvKGgGt5JP
 VVHBm15Gh73YaQ1txmdv1Ss5UxfUEWcfLrZ/Fpg66xAYKSI2Qh504278YLnTiTmrq+O28upBIXF
 NxtUY0yxOT4wikwn2fIsQOtbdTmFFubvISYRWb/hk1KH47e8gskZGM6RCIvgi+mImZyFCbF1Z5b
 /25AI7UD40Go+uFm5/XIrIWA9w38dA==
X-Proofpoint-GUID: 9vJ3bcfUBreJRjpcxwhWBIb-c7J3Jla2


Hi Fangrui.

> - https://maskray.me/blog/2025-09-28-remarks-on-sframe (covering
> mandatory index building problems, section group compliance and
> garbage collection issues, and version compatibility challenges)

After reading your blog it seems to me that your main concern is (was?)
that SFrame "violates ELF rules" because it is not amenable to
concatenation (the result of concatenating two "sframes" is not a valid
sframe) and thus it requires specific linker support to merge these
sections.  This support, once in place, will have to be maintained
moving forward, and evolved along with the format.

First, SFrame is not concatenable because its main design goal is to be
simple to _use_ (not necessarily trivial to link) so it provides little
luxuries like a fixed-size header (uoh), it is self-contained, it does
not require an explicit index to be searched efficiently (instead you
just binary search on the data in place), it has no run-time
relocations, etc.  You don't need to allocate memory dynamically to
decode and stack-walking using SFrame, and it has even been proved (by
the parca project people) that it is possible to write actual verifiable
BPF to walk an userspace stack using an internal format that is in
essence identical to SFrame. You may not care about any of that, but the
people wanting to use the format certainly do, and thats the reason
SFrame (and ORC for that matter) is the way it is.  Sure, nobody would
object making SFrame concatenable to make your (and mine, incidentaly)
life easier, but not at the cost of burdening users with extra
complexity that they dont need and are not willing to assume: why would
they?  We are not even quite sure if such a thing is achievable in this
case: you either put the complexity in the linker, or on the users, but
you cannot make it magically disappear.  If you have some _concrete_
suggestion on improving the format, please by all means let the SFrame
people know, or consider following-up in threads like [1] where these
details are being discussed.  That would be helpful indeed.

Second, as bizarre as it may be, having non-concatenable data in an ELF
section only "violates ELF rules" if the linker _doesn't know_ about the
type of the section containing it.  So the solution is obvious: make
your linker aware of SFrame sections and, voil=C3=A0, the ELF violation goe=
s
away.  You can either merge the SFrame data, or just discard the input
sections, or call the Linker Police.  Just do _something_ about it,
because doing nothing leads to emitting nonsense, and that pisses off
everyone.

Third, this "problem" is not privative to SFrame.  Other formats like EH
Frame also require some degree of linker awareness, in the form of the
generation of an explicit index, or merging, or whatever...  apparenlty
to nobody's scandal, lucky them.  Pushing the burden of dealing with
this to users or to post-processing tools, like you suggest in your
blog, is IMO hardly a satisfactory solution: it is rather a no-solution
and an attempt of making your problem everyone's problem. Now, if you
then move the goalpost and claim the problem is the _degree_ of linker
involvement, as you seem to suggest in your blog, then again your
feedback is very welcome to make SFrame more linker-friendly, as long as
it is in the form of concrete construtive suggestions _and_ not at the
cost of the user's requirements for the format.

Fourth, some people think that it is unreasonable to expect all the ELF
linkers in existence to be aware of SFrame sections (not me; you can
count them all linkers with fingers and no toes).  ELF already supports
a standard section flag SHF_OS_NONCONFORMAT that tries to deal with
cases like this... and fails miserably: unknown sections marked with
that flag are not required to be amenable to concatenation, but the
problem is that upon encountering them the linker is expected to abort
the link with an error.  This is hardly convenient for anyone, so the
SFrame people are currently proposing to the gABI [2] the addition of a
new flag SHF_OS_NONCONFORMANT_DISCARD that would make the linker to just
discard the unknown input section rather than aborting the link.

Fifth, the problems related to GC and section grouping were discussed
during Cauldron [3] and I believe a solution has been already found,
proposed independently by Roland in the gabi discussion thread.  I think
that solution is being written down and will have to be reviewed before
being used in SFrame V3.  Your help on that review would be also very
much appreciated, considering your vast experience on these matters.  I
suppose it will happen in the binutils list.  I am sure they will CC you
in the relevant thread so you won't miss it.

Sixth, several people have repeatedly pointed out that it is not
reasonable to extrapolate the big gap between SFrame V2 and V3 to future
revisions of the format, and that not implementing V2 in lld is
perfectly ok, because the kernel will start directly with V3.  The
SFrame maintainer has assured, also repeteadly, that she is well aware
that any change in the spec will have to be very carefully considered to
avoid or minimize any impact in the linkers. I would say the fact she
also maintains the SFrame support in ld may also serve as bail to
guarantee her good behavior, at least to some extent ;)

Finally, it is not clear to me at all why supporting SFrame would result
in such an unbearable burden to lld's maintenance, as you seem to
expect, given everyhing is fine on the GNU side.  Please don't
misunderstand me: you know your linker better than anyone else and I am
sure there are good reasons that justify such apprehension.  What is it?
Is it lack of contributors?  Is the lld codebase particularly difficult
to maintain or extend?  Looking at [4] the people that are contributing
the SFrame support to LLVM are also volunteering to maintain it moving
forward.. isn't that enough?  Perhaps you need a co-maintainer?  Can we,
or anyone else, help somehow?  If so, how?

Salud!

[1] https://sourceware.org/pipermail/binutils/2025-October/145086.html
[2] https://groups.google.com/g/generic-abi/c/3ZMVJDF79g8
[3] https://www.youtube.com/watch?v=3DL2UmAp39xqk
[4] https://discourse.llvm.org/t/rfc-adding-sframe-support-to-llvm/86900
