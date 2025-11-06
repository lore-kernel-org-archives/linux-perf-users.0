Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736E51D61B7;
	Thu,  6 Nov 2025 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389915; cv=fail; b=mGRAukRMew0jSlNQzWiAwWWvrVHAtx6+aCLfQRzwoPZTEXpdg6P8hFYWkR/EDqK+7HUA3BKReuN8YJsGLFdptzr+UNPMX5jYv+rsFFM3x27UwdXYnmObpkr7TUPAr7/LQ3qnYfrc1MnI/3kA+Xg/fbAmxUz2U8/GlFrjZxgemWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389915; c=relaxed/simple;
	bh=NG/1EYX94nMvjasdbdkDU3owzWFHiAlm1PcMUDQ/SO4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=anZO8yIqqjDbPT+CtncbC+1RCwHtF+/rDjOLD+IrRcVpnGtJrFS/jDrEw7HjTbrKag8CLSYOL+DN1Z3KMLDScePQyOpcwHdxUY9FyerMib8Etujnzrwl5QMdMx0Lc4Zhu46U6LfvOjLZyu5MP2oWJQJhafYSlcwfa9sIxZlju78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VJ6CK329; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t+ghka94; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VJ6CK329";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t+ghka94"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A60Cv80014129;
	Thu, 6 Nov 2025 00:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5NZ9RQStRTALFiIJGrrYcPc6wyOnaax5d3JQoHTo/Fc=; b=
	VJ6CK329K+iurw8TaoLWnTeBrXWLPq1pG9IwjThHDi89EwjQnuxhtXo7RSmDCUxH
	XVeqg6ARXnHxLhln/6FucuDs4Bv0wnU4rQQ9FfutIpl/73XrlTNb7XTvQ1A2TzRE
	3faNs8ip3Us4mfzOj+0ThYCnUusohZlt1kVfwOqXM24Blfwt73sdB+sO5y7upuba
	zDXJpdYqyAq62BTk8/upvCIiWJ+hcEDDzVyRBHUStFDWpWjqorVbK+gLbVLUyTOj
	f5MVbof9ufqxZuzzKyDdzvnBKp4XYXJmx+MssH/kVhlL9Dd232p0KuqwOvAC+xDi
	ECDua8w2qs0CDe88BVg86Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8anjgx0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 00:44:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5MDpqq039511;
	Thu, 6 Nov 2025 00:44:56 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbg13y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 00:44:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcTWWfsrYGo/UcHEw/a53bwT0iIXYi90BEIzy74k511zR46qcl1uJenc0EyDD64eNHZNOkj4KuIcCNybIEZMm76XlEEmvZDay5bbPdpdUeNzJaJMmaHo3PS8ImLLCunIiZ7CfN9ZTI7i8vfta61qL4QBademGD+QFLYgQUTPTPTdj9Dr6M4+8vU4jjATlUvxsK9LlkRvLDV/Avepdc8riisiFdeszFKUzF39sIjXqa32HNcx/n+yU41t6x7WI8fqWpvxq53w6EMsUmVJYQl8jsUZdPtRrWST+wZ4jrOV5UUvCMd3VTuDKzRM9qLf+ShPenPTmMdWBePh56Qv1OoTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NZ9RQStRTALFiIJGrrYcPc6wyOnaax5d3JQoHTo/Fc=;
 b=U9zhwJi3TCan7TR8DBNKU0jYECJGgnQIe0HCWjufbcZKlDbGD+1YWBUjvjf3myuqkvOAxUvlYE2Pk8AwHf3YVEN1eBqh7PNyqd6sdh00cgggq7U/45JxixVfjeX7bw3c48uaW9I45bhq5w2o3Tjk69pWIC9bnZb5o9+rmspKrdEnFcfV1iE09nROSPLbe3yQJ+0UZfwvhI6eKgNuCS2ypFUGvryLnPSWvGjP/I5dLgP3lIYhp9v0v0eV6RZCwmz4x912G/VNG0rgdclikkMG77fw3nepCVTMmXS16g8OIi+ZlzrzXJd3A2ZLj19t0R3SI2NQxqU5ZPyQPxqo4StB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NZ9RQStRTALFiIJGrrYcPc6wyOnaax5d3JQoHTo/Fc=;
 b=t+ghka94v2ra5O2KedU9DGbbHFNhxmf/RcRGyqg4btVS6XR2YI82cJlM3oJ61P5uN3LCgceSSLsKxSC0Qp2fpeH+ZBfKqL5F3NKFd8pWWNyIhrZuLlpzN6KiOW8+spTZkATXPhRZeWFgFKUpIQ1WHHlLR/F5VMvS1lpUeZ0mwFM=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by IA3PR10MB8708.namprd10.prod.outlook.com (2603:10b6:208:572::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 00:44:53 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%5]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 00:44:53 +0000
Message-ID: <9c11b765-66df-46f3-b4ea-a0c7f52dac35@oracle.com>
Date: Wed, 5 Nov 2025 16:44:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Fangrui Song <maskray@sourceware.org>
Cc: linux-toolchains@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <2d713719-709d-4b46-8234-2dfe948b836a@oracle.com>
 <CAN30aBGEpwA+ZROXufqBL6MHM70oWTtNpGSioCMhxT8yS2t-Pg@mail.gmail.com>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <CAN30aBGEpwA+ZROXufqBL6MHM70oWTtNpGSioCMhxT8yS2t-Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:303:8e::7) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|IA3PR10MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 817c8bcc-5a48-4b2b-2a9b-08de1ccdb302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGk0a3Y5NUdLVzZ0VElTSG1ycWlscmRQb3E1ajZ3SGJGVURHM3Zqb09ZbDdT?=
 =?utf-8?B?cWRMWTJDK2Y2c21YZ24xcllJS2R0WmVSeGZZNHd3S010Si95R1dLSERmcHhY?=
 =?utf-8?B?SUx0T0JseVJDUGRYaVBXRzllSENndStFaUoxNkphU1VUK0lQckROcUJ2QWll?=
 =?utf-8?B?V0N5alZ0M24rWmthWFIyamE5VytiR0Q5R2ZJNzRwVFFJT0lZR3RxMlJMNUpO?=
 =?utf-8?B?cGhpVVoxVGo0elVLbGpka0x2cEhzT0xoNkdTdXdSODhxTUYzTlo3Y2l0K2k5?=
 =?utf-8?B?d3VwOVFIZDlUK1hkS0tTbXVXZ3Q0cW1JOXpyb1pWQ1p1Q0tjQVdNQnNvQ1M2?=
 =?utf-8?B?Qk9YY2k1QkxHVml6dXAxazJPOVVLNU9IWDdsV0hGK0RUTHFWaHVUdGtNQ0p4?=
 =?utf-8?B?dDA0Qjl1bmx2aEV0dlZmakljZEhNVnhibW9CYUlkS0dKUk1hWE9QWkFjSzNE?=
 =?utf-8?B?TmVRMmswUVlvVUN1WElLaVB2S0F0RW1RYlgzS2k0cnlRNVhjMGhvV3N1bm8x?=
 =?utf-8?B?RzZGMmp0di82bXVObmZDSDR2NWpuZVI1bk1HQkpyeGo4RVQ5Ly85eGQxQ25H?=
 =?utf-8?B?N2NMNVhIclJwZEkxRWpvc2YwNU9IN2FVczhXZGw1Z3YxSUgzZWw5MGVjSVJh?=
 =?utf-8?B?UnJXN1hyMWh2K2pzbFYwRWdGM1pPY2FiRGJJTUt5S3psTjVpbkF2UG5uSGZp?=
 =?utf-8?B?UG85bnVvMktTNTllUjZrN0tKYVR1QmdnUUUxN2dmNDRsVlQ3SzRsaWF0dCtQ?=
 =?utf-8?B?cUtRM3ZWNkwyYXROV2xjRW4wK3RiNnVpeVNsczJVd2l0VUdEeUVMeFJtQ2NF?=
 =?utf-8?B?NUNXNmRxVzlrRVYvYndxMjREQkU5L2FFMTcraXkxaG5GekVLL0F2bmI5SGVM?=
 =?utf-8?B?MjRnTTd0KzlTUjR4QVc4eHNtekk4d1pXbFRXcTJwbVFVZ3lQeTVMektTdzdX?=
 =?utf-8?B?S2xDL0VZUjgxMDB5elV2bk1zZ3pHT3lYZmRZSWplR2Q0MzNNdVIwZ2RrWGhQ?=
 =?utf-8?B?Z2hWL3RXUFNYcmFBMDhzZkxaUkpZTHM5NE0wdm1rWVU4NkNwQTNCeDJSRHY5?=
 =?utf-8?B?Vmt4bHN6VnNtYmhRTlJyYmxWcmZHcGE4TTVXTDJTd3AzNzhnbGgyTUk3QTJy?=
 =?utf-8?B?aFNmSzRUQjlPTzJ0ZTJKMUduN09JL3RIdUk1Vjk0bWdQbU5uNUFVaExtaEQ5?=
 =?utf-8?B?RnZzWFVMYjE0SE5GOVp5ZlljVXhheVVnSUQyTFNRVEQ3Mm52MGJyZTM5Mmlr?=
 =?utf-8?B?WUx2bExEeXpjK2w4Z2lqM1JvREN3ZHRMQkdTRFhTcUpOL1RCdmo3eVFVTGxX?=
 =?utf-8?B?S0xpbUtxNk5UMk1IbWdzZ2Q0QS9aZllBQUNYM0JRa01yakxLRDdmeGJNRDkr?=
 =?utf-8?B?amlhaTNUN0NlSzUzRTJGN2w0aWludTNTa2dqZDBIUTJUNTZTaFA1MnNqQkZq?=
 =?utf-8?B?cExVVVBOS1NqL25MNEQwWXR4RlU0akI0d0hxeVVNbk9wbkFJNHdSRU1Jdnky?=
 =?utf-8?B?K1JXS0VrRkdPVEttaWhIaGhXVTBKbncwbmZHb0Fld0VNSk5UakZHZmk2eFRD?=
 =?utf-8?B?ZXhTeSs1alFHams3OGpUNWp1UFRyaE4vcllWdGRzb2NPOUxETjVvVlNPaEM4?=
 =?utf-8?B?K210Z1kvMTZuTTJ2V2ZtRVZvUU9IcWljRmdnNStNalN4MWRjL3Z0RzNMRUhY?=
 =?utf-8?B?ZENkTFhOclFvZ1lyZUpaejJTODl6M1dFbWhxM0gzOEFabkZFTXFxa3Z2eDlK?=
 =?utf-8?B?RWNLK1Z3YTVTNEVGWmQrc3hpM3RLTkhhRFNxQTBUUGZPVzVtZkJ0YWZoTFlD?=
 =?utf-8?B?SVRBanh3a3JuNVVnT3VSSjM0WEM2aGxlUy9pUmNlQ2Z6anRyV3ErTnczdUl0?=
 =?utf-8?B?cDdyNStRcjVUVVNxblM4SHJmYWRoTEp0ZHVSMWtsNWtFWmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RktEM25pQmlwV1NlZ3VVL1lDemNlci80RWFsSHlBbldtaWxwcUQ4U09tTWhJ?=
 =?utf-8?B?cnNDdkZ1aXV2bk11SmdDQUF4c3ZWOWVXanhYYnR5VGtzUDhKS2M2Ui8wekND?=
 =?utf-8?B?L2Nqc0lVbXkrNUUwWlhoUkxxZW1GTHpaS2dIOVBLcmtGbnhBbHI4TmY0RTZK?=
 =?utf-8?B?bFpRaUJ0aUlWSzlhVWJmV3FaYXBhS0pmdENmaUZ6UXZWeis5dmVEeXZtUkMr?=
 =?utf-8?B?cWF2V2ZBY3NVOXN6K2pIMlpRZEVUWDVSZjVmOElBVmFpUTdFTlNOYUJQU09W?=
 =?utf-8?B?WmJnUEJGM2N5aGEvVXMyLzBFYWhBZDhmQlVjVGRTM1ZWOUZWUDVnUU9iR3ZH?=
 =?utf-8?B?ZHZOdjRreE1WYTY2S1ladkZyZThtVmFyV2NFSnBUdFV4RzA0ajZLOTROeFd3?=
 =?utf-8?B?LzEwOEVuREt6dzhqZXRvQ2NDeVF6b040ZzQ4eEk0SlV6MThzZW5GdFFVZlJk?=
 =?utf-8?B?YVZoWmx1bkRHaVpWc2h2Z2Y2OEFBdHZ5cTdCUkVXamdqOFF5aU15bTJJMVJC?=
 =?utf-8?B?TzcrTk9IQmlnREpPMzRrZjV6YXJpMzlwTmpHdVEvY2t0UVhMZkFYUWE0R1pt?=
 =?utf-8?B?SHVuS2RlWkFheEsrVnZxLzVXZTd1OXNGc0lkVzVUamZUeHUvRUNtUXlwRkJC?=
 =?utf-8?B?NG5ybnVOTjJjaWZKMlpzQmpSK0hxYkFMM0duS0QxOUpjTENFZThySUErYmFs?=
 =?utf-8?B?VmNhTGtHSHR6aUg5ZVdSMG0wNTdFQ0xQMTNhZWNlc2ZPSnNLQWJXYXluNDh0?=
 =?utf-8?B?RGZaVllJdnhqZjk4Q01WMS9ES2x5QzE1cmZZVUVpN016TXNhcjBiekFzOUZT?=
 =?utf-8?B?ZVlIcDJ2NzBsdWw0cmRmOXRacm9NVGxrN09KU1hYQzcxeEpsRUtxRmNYZll1?=
 =?utf-8?B?NXFHVG9IT0NLNVEzVEEwbUIxaE1uNSs2OUEweDdWcElmVVNNTFkzZFNWYll1?=
 =?utf-8?B?Y3dNMnc0NkFCQW9GQ1dqL3hIQlhqN1FPa2s4UFNteUVqRDVSUU83Qi82TGsv?=
 =?utf-8?B?cGJGTmtFQzdxSzhUMTIwZk1PeWRzeGt5RG5PT24yRnVReTkvWWJtT1RRdklm?=
 =?utf-8?B?ZUFrSG1Nc05ZcDMzNExNNnlPdkRCQ1BDN2lkWGtZTEF2NFk3MU0zbnEwNXNt?=
 =?utf-8?B?TDgvQm1LSGttbEt1YVM5Tjlod0tvT3pCMndvTEJwbVByRmFkWWE3ZW9hKy92?=
 =?utf-8?B?aU1hK3JVcitvRktYZk5PTUpZamZ3bVFhTGRKS3N6c056cHNxaXpJeU1SQm9q?=
 =?utf-8?B?V292UnVyMVZpRkV4WktQZDBXdFdmWmZoNEZHSEkxUjRQSmxMMzVhOTlHQStx?=
 =?utf-8?B?SlJnRkNXV2l1TGtsbldsejZPZTc2aWsreGFXR2JUTCs2d1RLbkVua1JHeDM0?=
 =?utf-8?B?d2pKSEg3K3haWHRUZkNZSVJQZWRnNVVCRXJtNFpWWEtuNW1xOVV5RmcwM0lz?=
 =?utf-8?B?RGlvSmpINGJNUms3L1BRWDhLQkFBZ2JyZDJpYkNZWmhCdWcvRVVTTUJtdjBG?=
 =?utf-8?B?NCtnd2xNSXRZUWJzZVdaR2FOanlIaVUvMEFwdEplbll2WmF2MnJJb25wMnBw?=
 =?utf-8?B?WmZJeW9qeXh2ajVJVVo0MEdHR0RHTHhHZzNLQ3ZXU0JJNHlzQVVTQ0VkUk9k?=
 =?utf-8?B?VGVOalBmMU9Walo0U3ExM055bXdvOEU0Y3NlSUl0aVpCU1k4MEZGbmNwaHJX?=
 =?utf-8?B?cG5ac1dFMmNIVWxvQ2NkYVlwWnRSbnVXak5OK2NZM1BKWG9Ib05zcEZ0WVh4?=
 =?utf-8?B?V0R0Y2RFSHhZbUczbjIxMDZSZmVDaTl4ZWV2akpqdWdHYmw1UnpLVEZ5Y2M5?=
 =?utf-8?B?Znd6UUVlRUNWTEVlMXpmd1BSN1FQak1MWkFHQ2E3dnpNcmRSYjJPMVNTWlZL?=
 =?utf-8?B?c0lXdGtwU0pJaGtEOWkzNlh5QVhvNmM4cnZ6R3Z2YWR3Z1pDUUM5N2dGSkk2?=
 =?utf-8?B?NldpblQxMlNpeWk1QzNYQTBBWDVSakM1OUNieVNNNkxRSHZPN2tQTjBVVGNW?=
 =?utf-8?B?QmM2MDdtR2JNY0tJSldsSUhZM2RBbVpPT05QcWl5d2lmVU5zanJqcXk1Zksz?=
 =?utf-8?B?MjRTdVlXcVdlaGhyQnlCYUtKSzZ5UWw0UDBkd0NFTkhiTXFhQWRENmgzdnI1?=
 =?utf-8?B?QzRzYW5RNmJtZSt1QlIzb3BPZVl4T21aNTNzT1lTem9HWHhOQjRESGN4a3BC?=
 =?utf-8?Q?SprfvsQp9KcnGEa8Fs3fob0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9E9HXVfLFwakl2+EbYDoAnl3pYGCVGflaeo41dWwL2/yksAPvrA4vuTym0l73Ac0j51JuJObAAJ+7BxGCEyYugio7d591UfppZ7d7bZbpSFIPrx3g0lfenJZFYJ28lQLTBFKKhapme1UiXJbdDC/G9chEs3rnT+LwqgkPWJLCu5LFYl9BSs72ihZsiCCrfjJbOfk3Yvfem7Ca5V1nhvC+XZiUBFCQekMzt5NWUPntlo89T7lHMJEgfwpTeI9Sab5ELzfZQKq1mNgc5mpCl42UyrxFzfhJTmuIF0Bj159SRxv/avnKTERTNO9DbG+v4o/POt7Y29b/gi0+raPLP4n6djUS4Ph5dtuqlxmL+qYtYmHctpGLyR5bA4HnQ36kIVRIH4tGojvZpyUq2Vfo3H1ovP8E3ZoNw3xw5k8cgHXtte87C2x6GgRIFNrgt/e38bFmJqIxUF7C5Xd0XRp4iDl5rbR2KsPHEedTsrC5UgpGtb/DWi+S/owfars6x9ZFjD2xT7BwOsmAqO5hdAzvf02zEOZrCpsxuG2MxRZxwTp1V27H5VbYPMEaobIqNK5MojdChbw1QFanHq24K2J3V+iZRVmN0t7UEwkt7nythnbbR4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817c8bcc-5a48-4b2b-2a9b-08de1ccdb302
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 00:44:53.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nksH5HUAj41d4mr3nEhmmKN6jF3c7t0YSpS3UW7/hN7rqoIlXhyiGY4rC1SAK20LALsF9I+xfpPBNXTwUuP3bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060004
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX+iue/92Smli3
 eMvCICdAx80HZHyBRis0HR0cOcshJvktGVS4/mVbKN5sFaJoXBha++4YhPzapI4ZFJtNIb7Si3E
 KzqFs4TgRq1khsQXnBL4MLlEmgmxQzc8no8fb6eCuB17rsVMBiJn7jga73fJjmCOhNZuP/GIerg
 DjUar9AbMyXL/Q/9sJPCeghR6SQUmBGkX5agkSSEd2J8R34tRnZedUIxq5XPQdg8IOkX8BoO5SO
 BTRNZBVOCrJ6uVFDaz6UAKsnoqLgX9hQ8m726y85W5O1YfaV3sKXPdwL6dCP9EnNXyrkt46AoUT
 CP46BUIhp6oy+E4Toh3kU+exR55xfGHc3ztma21UVpuwfalc09x0P+vODJNUfRURY1uwDPlJaVs
 4ZG2jC1FtjGoJXvzZFwZ9yBLd9f1vQ==
X-Authority-Analysis: v=2.4 cv=dfqNHHXe c=1 sm=1 tr=0 ts=690bef89 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8EG8Du73AAAA:8 a=Twlkf-z8AAAA:8 a=mDV3o1hIAAAA:8 a=NEAV23lmAAAA:8
 a=8ToAWqAZAAAA:8 a=QegZ8fZzAAAA:8 a=yPCof4ZbAAAA:8 a=bSRL9yvLBgwOelX9EwUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=eIFONfotB6AA:10
 a=m3iHK6Qi1fOmGZKaujnh:22 a=-74SuR6ZdpOK_LpdRCUo:22 a=G1HVL-rv9vdetxEvgG_p:22
 a=_Z14B2EILkUCX44yj2ln:22 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22
 a=nt3jZW36AmriUCFCBwmW:22
X-Proofpoint-GUID: ZtYKd_4ESBMgPNBb76mETwl9KIav2q8v
X-Proofpoint-ORIG-GUID: ZtYKd_4ESBMgPNBb76mETwl9KIav2q8v

On 11/5/25 12:21 AM, Fangrui Song wrote:
>> On Tue, Nov 4, 2025 at 1:21 AM Indu <indu.bhagat@oracle.com> wrote:
>> On 2025-10-29 11:53 p.m., Fangrui Song wrote:
>>> I've been following the SFrame discussion and wanted to share some
>>> concerns about its viability for userspace adoption, based on concrete
>>> measurements and comparison with existing compact unwind implementations
>>> in LLVM.
>>>
>>> **Size overhead concerns**
>>>
>>> Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) is
>>> approximately 10% larger than the combined size of .eh_frame
>>> and .eh_frame_hdr (8.06 MiB total).
>>> This is problematic because .eh_frame cannot be eliminated - it contains
>>> essential information for restoring callee-saved registers, LSDA, and
>>> personality information needed for debugging (e.g. reading local
>>> variables in a coredump) and C++ exception handling.
>>>
>>> This means adopting SFrame would result in carrying both formats, with a
>>> large net size increase.
>>>
>>> **Learning from existing compact unwind implementations**
>>>
>>> It's worth noting that LLVM has had a battle-tested compact unwind
>>> format in production use since 2009 with OS X 10.6, which transitioned
>>> to using CFI directives in 2013 [1]. The efficiency gains are dramatic:
>>>
>>>     __text section: 0x4a55470 bytes
>>>     __unwind_info section: 0x79060 bytes (0.6% of __text)
>>>     __eh_frame section: 0x58 bytes
>>>
>>
>> I believe this is only synchronous? If yes, do you think this is a fair
>> measurement to compare against ?
>>
>> Does the compact unwind info scheme work well for cases of
>> shrink-wrapping ? How about the case of AArch64, where the ABI does not
>> mandate if and where frame record is created ?
>>
>> For the numbers above, does it ensure precise stack traces ?
>>
>>   From the The Apple Compact Unwinding Format document
>> (https://faultlore.com/blah/compact-unwinding/),
>> "One consequence of only having one opcode for a whole function is that
>> functions will generally have incorrect instructions for the function’s
>> prologue (where callee-saved registers are individually PUSHed onto the
>> stack before the rest of the stack space is allocated)."
>>
>> "Presumably this isn’t a very big deal, since there’s very few
>> situations where unwinding would involve a function still executing its
>> prologue/epilogue."
>>
>> Well, getting precise stack traces is a big deal and the users want them.
> 
> **Shrink-wrapping and precise stack traces**: Yes, compact unwind
> handles these through an extension proposed by OpenVMS (not yet
> upstreamed to LLVM):
> https://lists.llvm.org/pipermail/llvm-dev/2018-January/120741.html
> 

Thanks for the link.

The above questions were strictly in the context of the battle-tested 
"The Apple Compact Unwinding Format" in production in the lld/MachO 
implementation, not for the proposed OpenVMS extensions.

Is it possible to get answers to those questions with that context in place?

If shrink-wrapping and precise stack traces isnt supported without the 
OpenVMS extension (that is not yet implemented), arent we comparing 
apples vs pears here ?

> Technical details of the extension:
> 
> - A single unwind group describes a (prologue_part1, prologue_part2,
> body, epilogue) tuple.
> - The prologue is conceptually split into two parts: the first part
> extends up to and including the instruction that decreases RSP; the
> second part extends to a point after the last preserved register is
> saved but before any preserved register is modified (this location is
> not unique, providing flexibility).
>    + When unwinding in the prologue, the RSP register value can be
> inferred from the PC and the set of saved registers.
> - Since register restoration is idempotent (restoring preserved
> registers multiple times during unwinding causes no harm), there is no
> need to describe `pop $reg` sequences. The unwind group needs just one
> bit to describe whether the 1-byte `ret` instruction is present.

Is this true for the case of asynchronous stack tracing too ?

> - The `length` field in the compact unwind group descriptor is
> repurposed to describe the prologue's two parts.
> - By composing multiple unwind groups, potentially with zero-sized
> prologues or omitting `ret` instructions in epilogues, it can describe
> functions with shrink wrapping or tail duplication optimization.
> - Null frame groups (with no prologue or epilogue) are the default and
> can describe trampolines and PLT stubs.

PLT stubs may use stack (push to stack). As per the document "A null 
frame (MODE = 8) is the simplest possible frame, with no allocated stack 
of either kind (hence no saved registers)".  So null frame can be used 
for PLT only if the functions invoking the PLT stub were using an 
RBP-based frame.  Isnt it ?
BTW, but both EH Frame and SFrame have specific, condensed 
representation for metadata for PLT entries.

> 

Anyway, thanks for the summary.

I see that OpenVMS extension for asynchronous compact unwind descriptors 
is an RFC state ATM.  But few important observations and questions:

  - As noted in the recently revived discussion, 
https://discourse.llvm.org/t/rfc-improving-compact-x86-64-compact-unwind-descriptors/47471, 
there is going to be a *non-negligible* size overhead as soon as you 
move towards a specification for asynchronous (vs the current 
specification that caters to synchronous only).  Now add to it, the 
quirks of each architecture/ABI :). Any comments ?

  - From the document: "Use of any preserved register must be delayed 
until all of the preserved registers have been saved."
    Q: Does this work well with optimizing compilers ? Is this an ABI 
change being asked for multiple architectures ?

  - From the document: "It appears technically feasible for a null frame 
function to have a personality routine. However, the utility of such a 
capability seems too meager to justify allowing this. We propose to not
support this." and "If the first attempt to lookup an unwind group for 
an exception address fails, then it is (tentatively) assumed to have 
occurred within a null frame function or in a part of a function
that is adequately described by a null frame. The presumed return 
address is (virtually or actually) popped from the top of stack and 
looked up. This second attempted lookup must succeed, in which case 
processing continues normally. A failure is a fatal error."
   Q: Is this a problem, especially because the goal is to evolve the 
OpenVMS RFC proposal is subsume .eh_frame ?

Are there people actively working towards bringing this to fruition?

> Now, to compare this against SFrame's space efficiency for synchronous
> unwinding, I've built llvm-mc, opt, and clang with
> -fno-asynchronous-unwind-tables -funwind-tables across multiple build
> configurations (clang vs gcc, frame pointer vs sframe). The resulting
> .sframe section sizes are significant:
> 
> % cat ~/tmp/test-unwind.sh
> #!/bin/zsh
> conf() {
>    configure-llvm $@ -DCMAKE_EXE_LINKER_FLAGS='-pie
> -Wl,-z,pack-relative-relocs' -DLLVM_ENABLE_UNWIND_TABLES=on \
>      -DCMAKE_{EXE,SHARED}_LINKER_FLAGS=-fuse-ld=bfd -DLLVM_ENABLE_LLD=off
> }
> 
> clang=-fno-integrated-as
> gcc=("-DCMAKE_C_COMPILER=$HOME/opt/gcc-15/bin/gcc"
> "-DCMAKE_CXX_COMPILER=$HOME/opt/gcc-15/bin/g++")
> 
> fp="-fno-omit-frame-pointer -momit-leaf-frame-pointer
> -B$HOME/opt/binutils/bin -Wa,--gsframe=no
> -fno-asynchronous-unwind-tables -funwind-tables"
> sframe="-fomit-frame-pointer -momit-leaf-frame-pointer
> -B$HOME/opt/binutils/bin -Wa,--gsframe -fno-asynchronous-unwind-tables
> -funwind-tables"
> 
> conf custom-fp-sync -DCMAKE_{C,CXX}_FLAGS="$clang $fp"
> conf custom-sframe-sync -DCMAKE_{C,CXX}_FLAGS="$clang $sframe"
> conf custom-fp-gcc-sync -DCMAKE_{C,CXX}_FLAGS="$fp" ${gcc[@]}
> conf custom-sframe-gcc-sync -DCMAKE_{C,CXX}_FLAGS="$sframe" ${gcc[@]}
> 
> for i in fp-sync sframe-sync fp-gcc-sync sframe-gcc-sync; do ninja -C
> /tmp/out/custom-$i llvm-mc opt clang; done
> 
> % ~/Dev/unwind-info-size-analyzer/section_size.rb
> /tmp/out/custom-{fp,sframe}-{,gcc-}sync/bin/{llvm-mc,opt,clang}
> Filename                                    |       .text size |
>   EH size |   .sframe size |   VM size | VM increase
> --------------------------------------------+------------------+----------------+----------------+-----------+------------
> /tmp/out/custom-fp-sync/bin/llvm-mc         |  2124031 (23.5%) |
> 301136 (3.3%) |       0 (0.0%) |   9050149 |           -
> /tmp/out/custom-sframe-sync/bin/llvm-mc     |  2114383 (22.3%) |
> 367452 (3.9%) |  348235 (3.7%) |   9483621 |       +4.8%
> /tmp/out/custom-fp-gcc-sync/bin/llvm-mc     |  2744214 (29.2%) |
> 301836 (3.2%) |       0 (0.0%) |   9389677 |       +3.8%
> /tmp/out/custom-sframe-gcc-sync/bin/llvm-mc |  2705860 (27.7%) |
> 354292 (3.6%) |  356073 (3.6%) |   9780985 |       +8.1%
> /tmp/out/custom-fp-sync/bin/opt             | 38873081 (69.9%) |
> 3538408 (6.4%) |       0 (0.0%) |  55598521 |           -
> /tmp/out/custom-sframe-sync/bin/opt         | 39011423 (62.4%) |
> 4557012 (7.3%) | 4452908 (7.1%) |  62494765 |      +12.4%
> /tmp/out/custom-fp-gcc-sync/bin/opt         | 54654535 (78.1%) |
> 3631076 (5.2%) |       0 (0.0%) |  70001573 |      +25.9%
> /tmp/out/custom-sframe-gcc-sync/bin/opt     | 53644831 (70.4%) |
> 4857220 (6.4%) | 5263530 (6.9%) |  76205733 |      +37.1%
> /tmp/out/custom-fp-sync/bin/clang           | 68345753 (73.8%) |
> 6643384 (7.2%) |       0 (0.0%) |  92638305 |           -
> /tmp/out/custom-sframe-sync/bin/clang       | 68500319 (64.9%) |
> 8684540 (8.2%) | 8521760 (8.1%) | 105572021 |      +14.0%
> /tmp/out/custom-fp-gcc-sync/bin/clang       | 96515079 (82.8%) |
> 6556756 (5.6%) |       0 (0.0%) | 116524565 |      +25.8%
> /tmp/out/custom-sframe-gcc-sync/bin/clang   | 94583903 (74.0%) |
> 8817628 (6.9%) | 9696263 (7.6%) | 127839309 |      +38.0%
> 
> Note: in GCC FP builds, .text is larger due to missing optimization
> for RBP-based frames (e.g.
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108386). Once this
> optimization is implemented, GCC FP builds should actually have
> smaller .text than RSP-based builds, because RBP-relative addressing
> produces more compact encodings than RSP-relative addressing (which
> requires an extra SIB byte).
> 
> .sframe for sync is not noticeably smaller than that for async. This
> is probably because
> there are still many DW_CFA_advance_loc ops even in
> -fno-asynchronous-unwind-tables -funwind-tables builds.
> 

Possible that its because in the Apple Compact Unwind Format, the linker 
optimizes compact unwind descriptors into the three-level paged 
structure, effectively de-duplicating some content.

>>>     (On macOS you can check the section size with objdump --arch x86_64 -
>>> h clang and dump the unwind info with  objdump --arch x86_64 --unwind-
>>> info clang)
>>>
>>> OpenVMS's x86-64 port, which is ELF-based, also adopted this format as
>>> documented in their "VSI OpenVMS Calling Standard" and their 2018 post:
>>> https://discourse.llvm.org/t/rfc-asynchronous-unwind-tables-attribute/59282
>>>
>>> The compact unwind format achieves this efficiency through a two-level
>>> page table structure. It describes common frame layouts compactly and
>>> falls back to DWARF only when necessary, allowing most DWARF CFI entries
>>> to be eliminated while maintaining full functionality. For more details,
>>> see: https://faultlore.com/blah/compact-unwinding/ and the lld/MachO
>>> implemention https://github.com/llvm/llvm-project/blob/main/lld/MachO/
>>> UnwindInfoSection.cpp
>>>
>>
>> How does your vision of "linker-friendly" stack tracing/stack unwinding
>> format reconcile with these suggested approaches ? As far as I can tell,
>> these formats also require linker created indexes and are
>> non-concatenable (custom handling in every linker).  Something you've
>> had "significant concerns" about.
>>

This question is unanswered: What do you think about 
"linker-friendliness" of the current implementation of the lld/MachO 
implementation of the compact unwind format in LLVM ?

> 
> We can distinguish between linking-time and execution-time
> representations by using different section names.
> The OpenVMS specification says:
> 
>      It is useful to note that the run-time representation of unwind
> information can vary from little more than a simple concatenation of
> the compile-time information to a substantial rewriting of unwind
> information by the linker. The proposal favors simple concatenation
> while maintaining the same ordering of groups as their associated
> code.
> 
> The runtime library can build this index at runtime and cache it to disk.
> 

This will include the dynamic linker and the stack tracer in the Linux 
kernel (the latter when stack tracing user space stacks).  Do you think 
this is feasible ?

> Once the design becomes sufficiently stable, we can introduce an
> opt-in linker option --xxxxframe-index that builds an index from
> recognized format versions while reporting warnings for unrecognized
> ones.> We need to carefully design this mechanism to be stable and robust,
> avoiding frequent format updates.
> >>   From
>> https://docs.vmssoftware.com/vsi-openvms-calling-standard/#STACK_UNWIND_EXCEPTION_X86_64:
>> "The unwind dispatch table (see Section B.3.1, ''Unwind Dispatch
>> Table'') is created by the linker using information in the unwind
>> descriptors (see Section B.3.2, ''DWARF Unwind Descriptors'' and Section
>> B.3.3, ''Compact Unwind Description'') provided by compilers. The linker
>> may use the provided unwind descriptors directly or replace them with
>> equivalent optimized forms based on its optimization strategies."
>>
>> Above all, do users want a solution which requires falling back on
>> DWARF-based processing for precise stack tracing ?
> 
> The key distinction is that compact unwind handles the vast majority
> of functions without DWARF—the macOS measurements show __unwind_info
> at 0.6% of __text size with __eh_frame reduced to negligible size
> (0x58 bytes). While SFrame also cannot handle all frames, compact
> unwind achieves dramatic size reductions by making DWARF the exception
> rather than requiring it alongside a supplementary format.
> 

As we have tried to reason, this is a misleading comparison. The compact 
unwind tables format:
   - needs to be extended for asynchronous stack unwinding
   - needs to be extended for other ABI/architectures
   - Making it concatenable / linker-friendly will also likely impose 
some negative effects on size.

> The DWARF fallback provides flexibility for additional coverage when
> needed, but nothing is lost (at least for the clang binary on macOS)
> if DWARF fallback were disabled in a hypothetical future linux-perf
> implementation.
> 

Fair enough, thats something for linux-perf/kernel to decide.  Once the 
OpenVMS RFC is sufficiently shaped to become a viable replacement for 
.eh_frame, this question will be for the stakeholders to decide.

>>> **The AArch64 case: size matters even more**
>>>
>>> The size consideration becomes even more critical for AArch64, which is
>>> heavily deployed on mobile phones.
>>> There's an active feature request for compact unwind support in the
>>> AArch64 ABI: https://github.com/ARM-software/abi-aa/issues/344
>>> This underscores the broader industry need for efficient unwind
>>> information that doesn't duplicate data or significantly increase binary
>>> size.
>>>
>>
>> Our measurements with a dataset of about 1400 userspace artifacts
>> (binaries and shared libraries) show that the SFrame/(EH Frame + EH
>> Frame HDR) ratio is:
>>     - Average of 0.70 on AArch64.
>>     - Average of 1.00 on x86_64.
>>
>> Projecting the size of what you observe for clang binary on x86_64 to
>> conclude the size ratio on AArch64 is not very wise to do.
>>
>> Whether the size impact is worth the benefit: its a choice for users to
>> make.  SFrame offers the users fast, precise stack traces with simple
>> stack tracers.
> 
> Thank you for providing the AArch64 measurements. Even with a 0.70x ratio on
> AArch64, this represents substantial memory overhead when considering:
> 
> .eh_frame is already large and being complained about.
> Being unable to eliminate it (needed for debugging and C++ exceptions)
> and adding 0.70x more means significant additional overhead for users.
> 
>>> There are at least two formats the ELF one can learn from: LLVM's
>>> compact unwind format (aarch64) and Windows ARM64 Frame Unwind Code.
>>>
>>
>> Please, if you have any concrete suggestions (keeping the above goals in
>> mind), you already know how/where to engage.
> 
> I've provided concrete suggestions throughout this discussion.
> 

Apologies, I should have been more precise.  And I ask because you know 
the details about both SFrame and the variants of Compact Unwind 
Descriptor formats at this point :). If you have concrete suggestions to 
improve the SFrame format for size, please let us know.

>>> **Path forward**
>>>
>>> Unless SFrame can actually replace .eh_frame (rather than supplementing
>>> it as an accelerator for linux-perf) and demonstrate sizes smaller
>>> than .eh_frame - matching the efficiency of existing compact unwind
>>> approaches — I question its practical viability for userspace.
>>> The current design appears to add overhead rather than reduce it.
>>> This isn't to suggest we should simply adopt the existing compact unwind
>>> format wholesale.
>>> The x86-64 design dates back to 2009 or earlier, and there are likely
>>> improvements we can make. However, we should aim for similar or better
>>> efficiency gains.
>>>
>>> For additional context, I've documented my detailed analysis at:
>>>
>>> - https://maskray.me/blog/2025-09-28-remarks-on-sframe (covering
>>> mandatory index building problems, section group compliance and garbage
>>> collection issues, and version compatibility challenges)
>>
>> GC issue is a bug currently tracked and with a target milestone of 2.46.
>>
>>> - https://maskray.me/blog/2025-10-26-stack-walking-space-and-time-trade-
>>> offs (size analysis)
>>>

