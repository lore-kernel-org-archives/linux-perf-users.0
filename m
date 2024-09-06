Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2104.outbound.protection.outlook.com [40.107.92.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45E53398E
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Sep 2024 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725664814; cv=fail; b=rPOJxgp0XhHcYZ0Ob3JxYeBS2/QzTfkdz9jSTj+6IWNjkXGatE5me/IoVTQSPghcpaTAwIRXF+LGBF/8D/FTad+kzGAluqRi8bbqDmrEyrJz8xvek58AYWangPNhLmDcaPB1Ff1UwxFjcqXsy8cyc9fDTUdVZ7tOLLLpSrkAKxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725664814; c=relaxed/simple;
	bh=u4xFWdDy3FD68GOe7ifRc6fSnvGHXZWsdw85cZfFRW0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DNFPVtjhtB52VMSLXrA5Iave86bo1krlAIRvsQwejz11y+08zjDHry07uTmXuzuf6jHDArhzZu7OkeUY7WCqNPVB3c+oaS2jtt2dzFGFx45gZFNyRDx99f+FGCwbAE2L1dHC58YT2PRDLBVU8gt6ME22v6w9asd+LS5C3DjjhQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=oz5D2SK9; arc=fail smtp.client-ip=40.107.92.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="oz5D2SK9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQuzduFaM2hpbBVyN6nv/EThtAx1IYXieB5GqRIpjdWFP1lrtsX1i3IIcdR35k9JkhcKmIe/99xTGkzj0jHoX8r+qXLw/sYn+rRnZb1bclxLmF3tw9O3cF1CiR+QMFjzJ4vFXbhgiJpO9ptJ9MRcw6RsbJDKN0sOupG+63snxalJxIDlbkylT5x/yuPaWZrt410x/8XU+0TRqF98dXo/nkU55Y3WvYvKdlg2fM1QpOVpVOx9IrV8fRm448aUAbLKBVBvrmilbGhhVB5BKyp+FtLs+xe385h143Vz31YrvPp/G2TRHjNkd6+RyJPMTKpCUvMsAPq1DgHa2zkkAl5knQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRTiWsrRFCL4ByTKIz3ArBvsXbruk7Rb0KsZCGB+08E=;
 b=t55qhmccC90bV8dmAVuJ977I2KpiuWgvDjvhiu+gqXMiTgqjsp6g/AdTwSfb4y43C/OiFfjIy7ZfU+O+69G5lSgN92uOUfoQfakfVr+XQqACBlSE7FkB1CspV6G6BzmGjbFBbWstlni7c9jb2+IkBnC/UhsHZF5W2g0SOYtbFfV4utK0IYq43wMKtq5LhjhRZHyaBNr37YdO1w6dK+K6EgOADMtfu2gkLXkCJhIbrIUhKcLor0rbRO1CaXcHbVVc1PGr2QTnocqw5j1DBPGJD9o+nqmTHIVj48nPNfK7rrtqarAy/CFlYA8mTL0Hyn0v23iNp0+XEOsC1F8Ae60vdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRTiWsrRFCL4ByTKIz3ArBvsXbruk7Rb0KsZCGB+08E=;
 b=oz5D2SK9H2bIPgrLJ+eniT578HvWqN4YLj2lRRcVwwaxX5MlcIkCTMlrXkd3U6jZ9rkpAYUSLylYZQhXmHTQq4ojYEfy3eATwx37fY5Z9Ktf8BP//l+8+MYrySimb6z5nfw6hJuP7YZqs1/kyELQ4YZHN5jICaW+VP1+2PMu9JA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SJ2PR01MB8584.prod.exchangelabs.com (2603:10b6:a03:548::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Fri, 6 Sep 2024 23:20:08 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 23:20:07 +0000
Message-ID: <22539ca0-551d-4cfc-94f9-4a291998a363@os.amperecomputing.com>
Date: Fri, 6 Sep 2024 16:20:04 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V7 4/4] Adjust objdump start/end range per map pgoff
 parameter
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: Leo Yan <leo.yan@arm.com>, james.clark@linaro.org, mike.leach@linaro.org
Cc: ilkka@os.amperecomputing.com, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1725573309.git.scclevenger@os.amperecomputing.com>
 <d730ad217936d952008edf703ba4c34393d89dad.1725573309.git.scclevenger@os.amperecomputing.com>
 <22f7ecdb-14e7-4bb1-a20a-bdb447bcb64f@arm.com>
 <723912a5-4d9a-4fe0-ad86-bbd79ccd4a45@os.amperecomputing.com>
Content-Language: en-US
Organization: Ampere Computing
In-Reply-To: <723912a5-4d9a-4fe0-ad86-bbd79ccd4a45@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SJ2PR01MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 31896fc2-76cb-41fa-f39a-08dcceca7229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|4022899009|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUF5N1JtRVFaUVN2STZncXpUajhUdHRrcUpEekZRQ2JkeUJsa2I3djY2U2pN?=
 =?utf-8?B?YnU3cGc3YVVmSHl3ZHRBOWtPcGpxa0hWMDJpcllMZW9kMlhDUHNkN1VTdkdR?=
 =?utf-8?B?aU5WZC9jSjJadmd0WDhVVTFuZEVNbmxNeGVHTVZ1enZ6cDlTc1BQand0bjhY?=
 =?utf-8?B?aEVCamtnWmViSm1nY29oUnBOTld0SStTaCtLUFBDTS9TYUZVMlFpeURNTzVR?=
 =?utf-8?B?dUxrOHp2Z2JMUW13NGZqdHpGMDdzNFdHUXFoTW5aaStHeEZDNWNnMzFPbkZJ?=
 =?utf-8?B?YlBkV1h2V2llaE54RDBEUnF0UTE2TVhxMEprZEh2KzhHMnlKdHVQQTRtUUZ4?=
 =?utf-8?B?K0hVazhRNTdqbXpmZmlnYnNoK0d2TEptSnNycWNSdDBPNHBqQThLZk5Ba0NQ?=
 =?utf-8?B?TUFrc0IramhmVXlJY0VJaGphd3duWWVWM291WWRKQ05hd2gxSkkxL0oxcDZu?=
 =?utf-8?B?b3pSTFVYbklPV1M5MnRIQm5Hc0FZWkFwcEpiOFJ1cjBQWFU4Y3pIdC9jQWZz?=
 =?utf-8?B?T1I3YXVSOFVPSWdJOEZIM0xTanNJL055bzNBaVBVL1lXT1JxVzJBOVBUNDFL?=
 =?utf-8?B?Rm04RGt2RURvNWVoNHUwbjIwK08zNURkakFWaHdKZG5IeEg5cUNmVEJ6aXdS?=
 =?utf-8?B?RHc3bUJQNVRFVEY2QjN4aU5UWjFkMkkwLzZRaFFkRUthdU5QcDc4bXRjRWlu?=
 =?utf-8?B?Z0JqRVh3QU5DMG5VQm1nQjE3NnNIZzZOMXcrTGNjbkYwTWJ6Qi9Nb1k2b0Mz?=
 =?utf-8?B?c2lRM2ZldHBZbnQyZ29uMDRxMDUvdWhNay9EWE1wNXlHT2ZIYVdhcFJIbzd1?=
 =?utf-8?B?SFA0OGI2RC9hOTgrdzBBR0t3cm9OMUxoemtnSG1JVVIvZmNLODBJdUZGNlJ2?=
 =?utf-8?B?eTl4dFVhaVY4c1ZhdE5OYUVxTlE5TXVaMGtSaElEMDRibjNKZm84cFF1S2tF?=
 =?utf-8?B?UXBvTzlkemJucE03aWJ5MUQwWkRsWWpOTTM2ZFBnRitkdXArSkQ0UHJVajM1?=
 =?utf-8?B?MHoyZWE1VW1BbENiclZsanRxRmVvS3VLL2ViNTJpV1NzbVd0OEVzcHdxVEc2?=
 =?utf-8?B?ZzlLQUpSSnJLTy9pYmV6RkhmdzNlOEZhRzNPUzVBREZSTDBWOXpNUlVwWk16?=
 =?utf-8?B?L3M4NEpleEhlNHdhR3MraSszUGhrTVl2VTlMaitrbDFxR3IrcDBZSEZGOEIr?=
 =?utf-8?B?WFlJQlhBYkhHSzhEMlgxdFFFWkZqbHFJZW8rSDMvMlRVOFRrclpjTWhmcHV5?=
 =?utf-8?B?REJYZjNzNGtNK05zdjhoY0V6R2dTMXA1clUyRFEwN00zVXlIWHg4djh0YmFk?=
 =?utf-8?B?eFF6VzRuc3RTVDAxY1E3cDBxMG1rcEdWclFPaGg5Y2ZwczhQL1lYNmo2UWVX?=
 =?utf-8?B?NXgzNk02ZXVQTDhTZm9oSEdERUVhUVZvbHNSKzdJcVdlWU1pSmE1aVEreENW?=
 =?utf-8?B?K2YxekJ6b0lwVDlTUkp3QkdFN3ZlM1lGTlpqb3JtcnVZMU0wSG9JaTBiZ2Nl?=
 =?utf-8?B?S1hsU3lRbHV3MXNCOUZQV0N4L3pkOGkxUlZ3ampLS3p4ZWd2RjVtVFBSbWhj?=
 =?utf-8?B?V2hEcGlFN2ovMm8zUW9FL2F3ODcrWWxyOXdPRkdWV2dqWEsxQW10YU1yZU9M?=
 =?utf-8?B?Yy9ScUM4WWVtUkY3YktFaE9sdkFJUE8vMHEvT0daRWJLVVppRmNPNSs2WUhD?=
 =?utf-8?B?bk1EVzJwOGk4TlpUQk1WRXZMWnZYK0VmTnFTZnFIa2FSSi9OemgzN09qZTVp?=
 =?utf-8?B?Yng1dkY5TDNhWGNxSkZzb0dJc1hKelpsN0tucXdQUWxGVnRaVXdxUWNmWDh4?=
 =?utf-8?B?VnpzOEVLVS9BT2NIT3FNUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2ZLMENxMlhYZVRHUHc2S1lFUlE1cVIrWGU5T2RuQ28xK3MvVk04QjdZODN2?=
 =?utf-8?B?ZElNc1BNYnJYT3dsZE1WWCtHa0hjZ3dTcXREemQvbWFsdlFPQi9wY3NyYnRP?=
 =?utf-8?B?MVZmOVA1aXBNcS91SDY3cGVQWGNqU0dXMy9QWFJtcjZkYnh3OXFqdnAzT1NN?=
 =?utf-8?B?YlF0QW82VlR6ZHhQOHhaU3cvWi9namo3VkVsOHBSNGVPRHo4NTFzVy9PZSt6?=
 =?utf-8?B?NmtKRnhPNnM1OHVsUGpFck04VzlGWXZCVGx1VzF1S0R0TVZyYXFZZ21odUxw?=
 =?utf-8?B?Sld3Y3p4RTBQZzdKRlE3SENWRWUyQnBCeVZmVFluOXI4T0FhUWNhd2lDcTdM?=
 =?utf-8?B?S1YzMzlIMC83K3dCR042Y2JBOHB0eHNxcG9kVk92MjR2Nmh4RVNDZmMzMmFn?=
 =?utf-8?B?aDVkL2pSQWpwaDI5QzJXUFBHdG9McDJ5Tkd6S1MzckhmYVh2K2d3QWx1Y0x2?=
 =?utf-8?B?eWcrVFdkSXpHckN6Z2ZydWJ2T2x4UHpXWFVDZElER0JLK1NhWGtqR3NhSk1y?=
 =?utf-8?B?Z0JUNUlkKy92OW1Xc0hWdHY0eHQwUGUrbVdMUysyeTNEdWVJOFhiU01ZTWFZ?=
 =?utf-8?B?dW1zVFQyQ01kNnBYR2pMREd4bFNYZ0V0eVllOHJZeHh1enJzVVJDMmN4ZFNK?=
 =?utf-8?B?S3NMODNlN2E2TGw5cVRkc09ub0RLeE1Zb1EyaGVyRTJnZWUza2t1ZzVPdVJM?=
 =?utf-8?B?ZFlML1ZQdjJZakdEVG1sdzJRSkprbXA2NXdZbktlS0doSURJZktyWG9jUlJU?=
 =?utf-8?B?Tk1Sc2RwN0hEdkRLbC81cm1pMlRsSk9NMmpiSjFQY0lYQlpVYkZKdXpaV0oz?=
 =?utf-8?B?c3ROamZTYnZLU0xaQmFZMFlYUTRoQ0J1UExGc3NMWjkza3pRTDJnRXl6Sndy?=
 =?utf-8?B?ajR4YStRekpzUC9EMFZ5OWN5bGNZb1FEK1hYa1JZNFhiTVJkNytSWkNUa3Vx?=
 =?utf-8?B?cWpKZFpRdFpZbTlkTWxqQnM5dGp0ekQ1L01TNjJacHhwaW9CWEJNSE93V0dy?=
 =?utf-8?B?UEdkdmpVUm5iZ0doandndzVXdm9qZUZFRDVnSkVEN1BkSlRMalVqRHJLeGdV?=
 =?utf-8?B?TmVGcUJRMC9PMURmUXVONXVtTEs1b0JLUkhRREdEejQ3alR1eEw5QVBDTFp4?=
 =?utf-8?B?MUtYSlNYZGNEYk9TZUxWOEFDTUlVUEVTdlllTC8xNGRBY3RGNnY4ZXpmMDBR?=
 =?utf-8?B?UWZWSXQ2NVZlQWpybzl0dktjc2hEckhHSWFhaW9vTDU1WmE3L3RIdGY5Tnlt?=
 =?utf-8?B?Y2V1dDZyYjVrbzE1REM4dkYwUko3aW8xQWFYV2dYT1d6RjE2QzRIbkFiUS9B?=
 =?utf-8?B?aFB1aVZ4KzlKR0NBVkMzeDh2TkJFTTM1bFVkNThxckFlNTR2R2dHUDBsMHF4?=
 =?utf-8?B?eEYvbDNyTFpWWlJzQnRyVjlZb0gxSE5ua2MxV1JOeUIvYVFYbzY2V255amor?=
 =?utf-8?B?V0hObnJvTytBSHUxNXhkdEFJMjVla3NVV0IwYk5TYTV3bE8yQnF5bFhOZGRE?=
 =?utf-8?B?dXdHSm9rUUEyNDNMWXhoNVMzaFNhdlYvc3VrM1VXNTlKTVdJbStXU3BoYmMv?=
 =?utf-8?B?VHlUNjNwMytVZFZSVTJkRmdpSGFaaXpBeFBHdGdNM1dNR0F5LzNkODVzeUNW?=
 =?utf-8?B?T2RQbHFnZ2ZBMllGb09xblM3MzBlSi9DellmWitleHJjeEo2TXNMeS9tRG13?=
 =?utf-8?B?MktjZ0Y2dzJMc1ppVDNrenNTSkhJU3owaGFOdklFTi94REJ6Q0ZGYSthbDZa?=
 =?utf-8?B?RGtIdEVBQWlpYjhid2gyd0lOclA4WUNVdVhLN3JHL2VmTm51aWM1c1AxWno2?=
 =?utf-8?B?V3VBaFhDRXhGTkh5OHorWXl3UWdwYThLc1lGQThaWVlYLzNrSFkzK3RRcUVr?=
 =?utf-8?B?MW1SUXpnNXJhTTNnUUZmYXp1WUZENmttSkVHVmlJT2FKV0R0Q0RXS1B2alc1?=
 =?utf-8?B?aEJmVjh3ZTJ4RUI1K1F2a1FoTFNUcmkzVEhFQVdVaEZ4YkJtZ1RERmJiaWs4?=
 =?utf-8?B?MzJ4d3VpdUxaTHhYNG9SWmVZbzZnbVBSM1hTYkhTeE5CakREMlFPd1JLNjRZ?=
 =?utf-8?B?S2VURmZmMEc4cGlDdHh5ZFM4OGwyQW1sNlVuNWVKRHFZT3RTK3pzWnp5TGdH?=
 =?utf-8?B?SlJsd3RzT3BNT1VsbllhL0dyQlg3ZXpzSmZ1N1p2UjZRdGdTeWJtWFlmVkJ5?=
 =?utf-8?Q?CSdR4kclXxtXCvwFI3S4bY0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31896fc2-76cb-41fa-f39a-08dcceca7229
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 23:20:07.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgOAt0fXFgew8ZhjvsJMen5RMfUB+q91DJpwpLm6yEZ132BzH3x7r8TSsAYaKvC3NKG6hMDR7rx1/Q17wEtcA6PNWC1IMFfrvbU3E9+cW0gN2OTzCJGMWZCwsp6ka5Mi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8584



On 9/6/2024 10:27 AM, Steve Clevenger wrote:
> 
> 
> On 9/6/2024 4:27 AM, Leo Yan wrote:
>>
>>
>> On 9/5/24 23:28, Steve Clevenger wrote:
>>>
>>> Extract map_pgoff parameter from the dictionary, and adjust start/end
>>> range passed to objdump based on the value.
>>>
>>> A zero start_addr is filtered to prevent output of dso address range
>>> check failures. This script repeatedly sees a zero value passed
>>> in for
>>>       start_addr = cpu_data[str(cpu) + 'addr']
>>>
>>> These zero values are not a new problem. The start_addr/stop_addr warning
>>> clutters the instruction trace output, hence this change.
>>>
>>> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
>>> ---
>>>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 14 +++++++++-----
>>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/
>>> perf/scripts/python/arm-cs-trace-disasm.py
>>> index 7aff02d84ffb..a867e0db02b8 100755
>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>> @@ -187,6 +187,7 @@ def process_event(param_dict):
>>>          dso_start = get_optional(param_dict, "dso_map_start")
>>>          dso_end = get_optional(param_dict, "dso_map_end")
>>>          symbol = get_optional(param_dict, "symbol")
>>> +       map_pgoff = get_optional(param_dict, "map_pgoff")
>>
>>
>> I am concerned the two sentences below are inconsistence: one uses
>> 'start_addr + map_pgoff' and the other uses 'start_addr + int(map_pgoff)'.
>>
> 
> Valid point. It's working fine as is, but how is it even working? I look
> at print_disam/read_disasm, and no type conversion is done in either
> call. The dso_start parameter for these calls is actually dso_vm_start
> which is the dso_start integer conversion.

Python thinks the map_pgoff object is already an integer. For example,
	map_pgoff = get_optional(param_dict, "map_pgoff")
	print("%d" % map_pgoff.isdigit())

AttributeError: 'int' object has no attribute 'isdigit'
Fatal Python error: handler_call die: problem in Python trace event handler

Converting map_pgoff to a string works in the print statement.

print("%d" % str(map_pgoff).isdigit())
1

I'm not sure, but it's possible get_optional() during some call had
converted it to '[unknown]' which would cause a problem.

I can explicitly force to integer.

Steve

> 
>> Here about below code?
>>
>>            map_pgoff_str = get_optional(param_dict, "map_pgoff")
>>        if map_pgoff_str == "":
>>         map_pgoff = 0
>>            else:
>>         map_pgoff = int(map_pgoff_str)
>>
>> With above change, 'map_pgoff' is an int type. As a result, the changes
>> below can simply add 'map_pgoff'.
> 
> I propose:
> 	map_pgoff_str = get_optional(param_dict, "map_pgoff"
> 	if (map_pgoff_str.isdigit()):
> 	    map_pgoff = int(map_pgoff)
> 	else:
> 	    map_pgoff = 0
> 
> The int() conversions in the print() statement can then be removed.
> 
> Steve
> 
>> With these changes, LGTM:
>>
>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>>
>>
>>>          cpu = sample["cpu"]
>>>          ip = sample["ip"]
>>> @@ -243,9 +244,11 @@ def process_event(param_dict):
>>>          # Record for previous sample packet
>>>          cpu_data[str(cpu) + 'addr'] = addr
>>>
>>> -       # Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
>>> -       if (start_addr == 0 and stop_addr == 4):
>>> -               print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
>>> +       # Filter out zero start_address. Optionally identify
>>> CS_ETM_TRACE_ON packet
>>> +       # if start_addr=0 and stop_addr=4.
>>> +       if (start_addr == 0):
>>> +               if ((stop_addr == 4) and (options.verbose == True)):
>>> +                       print("CPU%d: CS_ETM_TRACE_ON packet is
>>> inserted" % cpu)
>>>                  return
>>>
>>>          if (start_addr < int(dso_start) or start_addr > int(dso_end)):
>>> @@ -262,13 +265,14 @@ def process_event(param_dict):
>>>                  # vm_start to zero.
>>>                  if (dso == "[kernel.kallsyms]" or dso_start ==
>>> 0x400000):
>>>                          dso_vm_start = 0
>>> +                       map_pgoff = 0
>>>                  else:
>>>                          dso_vm_start = int(dso_start)
>>>
>>>                  dso_fname = get_dso_file_path(dso, dso_bid)
>>>                  if path.exists(dso_fname):
>>> -                       print_disam(dso_fname, dso_vm_start,
>>> start_addr, stop_addr)
>>> +                       print_disam(dso_fname, dso_vm_start,
>>> start_addr + map_pgoff, stop_addr + map_pgoff)
>>>                  else:
>>> -                       print("Failed to find dso %s for address range
>>> [ 0x%x .. 0x%x ]" % (dso, start_addr, stop_addr))
>>> +                       print("Failed to find dso %s for address range
>>> [ 0x%x .. 0x%x ]" % (dso, start_addr + int(map_pgoff), stop_addr +
>>> int(map_pgoff)))
>>
>>>
>>>          print_srccode(comm, param_dict, sample, symbol, dso)
>>> -- 
>>> 2.44.0
>>>
> 
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

