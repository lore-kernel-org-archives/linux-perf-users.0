Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D17F143755;
	Tue,  4 Jun 2024 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507460; cv=fail; b=u6XD7WH+y9jDPo+JHSl9EFEGB1pnaVPHKVqEuPUTsAZWFgPNkE6+ampc0hjLEkaYVPJKWLjat/VXykpfU9L0JcjcpEFbnS7vw51gq/fAdNEOrj3uw3L5TiWur/Xf7FTMwbpBh1OotWNzbB9Fb7I54SxfEaBKs88X4HU04rDrNH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507460; c=relaxed/simple;
	bh=LIB5elinGAipn7efVuy1FRubowGEX0R419E6919HFmU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ne7bIjM2o6wHPvw9Yj6QpUza6bzCIS1yRi+8SmfGBht5QsynZbsOFkd9HUMMG5EsFNvAhTTSwNnb08gjjVe1ziv7dOIQ9DEbCfNSJn+4PjlvXZKaQ8LnM6JhgaUZNoPwPCaOP63Ddl7VO3KhxYOsPSNE4iYUl+GuAWf9ZEBcT6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BnGJb028053;
	Tue, 4 Jun 2024 13:23:45 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DDwqJusKoNHGPeH/5+d5j3v3siR+BDK6isyARLFoLP2k=3D;_b?=
 =?UTF-8?Q?=3DCZBf6idgkSUcebisRzguZOgC2W3eSuGu2KJiYDgyYngjS5QLs0uaFZ+6ZxBu?=
 =?UTF-8?Q?2cVaGs30_7dk7EPHztqZWGLpy2flAN8KMzHA1rt93NbokHrbP5Bf2OzfMrjcd/Y?=
 =?UTF-8?Q?Fg3RV8XafDXYur_HWQefdIOc2Z+LzYP85tC5FqGl6qXfG+UiKHL3BZxm0Kqczwf?=
 =?UTF-8?Q?Q7fT/v+fuRFVbEQeZEag_m+tyAItyjoy+6DP62UJcmjxrbpOKWWIhf228mK26Yv?=
 =?UTF-8?Q?sIO17YMA0Zheplt4Pgw6FDSz2r_2/CuykzsffGQUuSsPCuX/WGDj2hKzRS0gATG?=
 =?UTF-8?Q?YtmNKB+I+nz2h1Q/NE7V4PZEhoL7Uv4f_Tw=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv58cy8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 13:23:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454CrlNt015557;
	Tue, 4 Jun 2024 13:23:44 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjcamcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 13:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gU9Zs26ZOFXP3PfkqHHWqPMDf06KV2VRj34zt9Dm9TEvmf6PyuVHF/QzT1T3h37MEXJ01ytlRkpb0drOwOVxi78TLE1RjH14tVtrzvAlw8UeCjGIE7dtfXmDH1HbyLJJssNPgHKX7TKYcmHHQ32FRVTlNcpg0NzYRryYN0HoLvR6tLNyXmlzHqhw7bk9RiDsVVDyWH0py1yVn2g/a9VSuuAOope6+5L1kW2XkCTF2L366D7VbuukMDaejsq9iw0gPW8+6ARD8Cf+ekRC2oFEmXxeSbiCdKsvyfq9Avc1i4YroUJp+gZmRibaAcwgx+bbIq1ZG9PnBOlF7A/jGxR71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwqJusKoNHGPeH/5+d5j3v3siR+BDK6isyARLFoLP2k=;
 b=D1pbUdCC3V+iGJmFI4DomPHAZVFidmXuK3uETjo92QpWBx4Y2duDaCphPdf3QqUDqXf1jshhV9v3RTJDAbsmy3gN3C03Mx4f1O6aQEO4HNa8wrg2LUZH2cwbWUvANLb8VLdxuKxpJW3fvYwKZgC2u921b5HYNKrGgWP+6Jyv7KBBlMXHoH5ySrm3ZAShAsTjEpji5qtrbNyuwEwztBQUk0pT+Ngydyp4gY3/eeAJuQUPD/rrnywxKKHLBSe1O//Mf3PZZNrC1rS7Grg90PBg9k8M8XNe1ZpRNWi+TAZ6HgdAe4GOq/9JWUpdrgNzUg0+Do7wTATbkoUnxrrV9t8wWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwqJusKoNHGPeH/5+d5j3v3siR+BDK6isyARLFoLP2k=;
 b=DVDawArWyFtqo6sZerZ2SHHOxEEPRPVASyext8GI/u2pcWqiihTCaaQVIjMxltGz4cN3m32tWmCYMwrtMltUcLC7DXEdXgX0GCjuYGCrLDhE/ecW5pFda04rFdFiafLkgO/8leqqi+PzeUaSb8N2MDkOzssDvXZToXA0eWLRBk8=
Received: from PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 by MN6PR10MB8024.namprd10.prod.outlook.com (2603:10b6:208:501::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 13:23:24 +0000
Received: from PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83]) by PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 13:23:24 +0000
Message-ID: <7b27a039-ddb9-4beb-a1b4-ba2b74a3043e@oracle.com>
Date: Tue, 4 Jun 2024 09:23:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: check event before enable to avoid GPF
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: harshit.m.mogalapalli@oracle.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1716990659-2427-1-git-send-email-george.kennedy@oracle.com>
 <75f6aba1-8ed6-4ef8-8811-de40ae40be90@amd.com>
 <1e14ca4b-6e3e-4d57-acec-bc3ee2bed6ed@oracle.com>
 <0494aedf-9759-4427-a7f3-39a91bd5771d@oracle.com>
 <3ec1cb26-c889-45ab-b8cc-92f933a2b5d1@amd.com>
Content-Language: en-US
From: George Kennedy <george.kennedy@oracle.com>
In-Reply-To: <3ec1cb26-c889-45ab-b8cc-92f933a2b5d1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:208:fc::30) To PH0PR10MB5895.namprd10.prod.outlook.com
 (2603:10b6:510:14c::22)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5895:EE_|MN6PR10MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: be50a6b4-3d65-4cca-27ba-08dc849982c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QmVod2xpeWswQWs3SkxQRGxkM2J6TFd0czFBQjI4OWNWdWN3S05XL0RXSUJ0?=
 =?utf-8?B?eUF3Ukx2cUt2ektWaU5sMllSNnNuK1hpZXVnM24ycmVYM1VnOHNOaERSNGpV?=
 =?utf-8?B?d1hUMEVxWjd4NVdCNFNvQVJUMERlVm5iQng5MEs2QmtWa01JRVlWS2dCWmJU?=
 =?utf-8?B?SHE1Y0hoK09HSGsvT3NsNUpES3J4aWx4Rkp0RjlmMm1Qc0lCQ2dWcSsra1pW?=
 =?utf-8?B?b2cwamJXam1EK3NjeXhQaVhZbFQ1Y0JtTUN0K3pPaitnd0NrTUJmNVArelNQ?=
 =?utf-8?B?WXNtUys4VWJsOGo2MUtmOENINmNoUXBuTlpKWjUvSFoyd3dnR2Z5aXUwU0Zl?=
 =?utf-8?B?MWZaZ3RNaTdzQ1BpNTlOTXZlcGkxUHMvV3dzZVFqQ2NxQkJZQ3MrWnhweTlF?=
 =?utf-8?B?NWVYcHVFT2NQVWQ2dWNZODZJRGh1TFZuOFdwb0x3MHROYUZTcUZEYVMwU2Fy?=
 =?utf-8?B?T0NzTDJQdEFVYlczSVlnbW1pLzZGNXBiVWs1dmJSdHVndmdRU05uWWx0akgr?=
 =?utf-8?B?a1FuWmxtM2UvN3JRZlUxSElGajZORU4yWnJkYmhEWnRKTzNRblhubExsL0NU?=
 =?utf-8?B?UTRrODVDdkx1cVk3U01XUFZVV0dqU0pjTHlEenBaNElzdWEyQU1SMy9TZWFZ?=
 =?utf-8?B?cEhsU3lJT25WN051UExvZnBTTXo1M2tWM0N3ZndITkZFSWo4L1hDUVNSQ25Y?=
 =?utf-8?B?OXZaMWJ4SGoyL3k0M1VvczZYUGU3aVBUL1loaXZhTU5xdDVpbmxrOFZUdzRS?=
 =?utf-8?B?WmpJeFBCSU51eE4wdGNJQ0JuSlhiZFlBeEVPNVRaNmdRd0pYUEREdmt3dkpL?=
 =?utf-8?B?TjFNSS9aRGU5WmlabGlUbndlOTZ1UzgvbkVjZk5SVkluS1VwMWU2UEM1d1VC?=
 =?utf-8?B?M2Z5dVF5TWVNNFB2OVNMLzdqTTRrdmdrSmc2TVE4MVNlQjQ5SWl2eXMyaCtB?=
 =?utf-8?B?OG40UldzbDJ2MGEybzRzbUlQc01ONVpsY2lwQ1c3QUFOVmcyQnRlMHB6dkl3?=
 =?utf-8?B?TzljaXZHTDdzNE8yTzFJZ0psL2h3NUt1VXovOGNmZTJaUTdYd0lONC9aMkEy?=
 =?utf-8?B?b1RuYlNJcTJFM0k4bTB6dlpZWjZESDZtWU96SXFCMm1KOW5wZG1JQlNYSG5s?=
 =?utf-8?B?VWRVTUwySjZZa3RCN0Z0MjU5NW1zSkNLK1hNTDNnejRjbEkvY2VsVUtaSE5n?=
 =?utf-8?B?QjFnNDRUUmZyYkpnMlVkYjVZQlkxWE1raW1LMW84SHdkTVQwYWdrcFRGNFFy?=
 =?utf-8?B?Y3k1YlNtcXhsanVjVHpDTlVscEZiRjJEMGNISVYvK1Vwb29TNUZmdGpCeGFB?=
 =?utf-8?B?Z2VZOHVBamlVa082VXIwUGl3bWx1N0JsMGtvUm1mSncxd3NkbUIzMUhzOXUr?=
 =?utf-8?B?bTNYQUhPdnFnREFmQ0pDZFVmL1BVZjVPaUsrTUQyNHc1TEVKRkxGclJFUUJD?=
 =?utf-8?B?TWVCVEFGUzIvenNJVndFSlZncWFZb3JKbCsxbnc0K0lxS1orUEQ1U2FBQk13?=
 =?utf-8?B?ekdCOUh6WXVyRXpINlBWN1F2L1plTWNXdHhCOVA4VzVWQUo5QXkwU0xoWjFi?=
 =?utf-8?B?NW5vYzNPYmtVVjZZWk9nOGpiajhMT0Vub2w3OGpjSGJxTVc5TVFQaDF1bFJS?=
 =?utf-8?B?TVhSaHhGOWN5VDE1U2k2TEd6Z0U5YWc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5895.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y3dNQmJ6Vk0ybWIyY1BKdjZvaHpqWjVJSmNsSnZmM1hGS3dDeWtNa2lhcWh3?=
 =?utf-8?B?UG5KYjJtVTZLQlRTbHFabDFOeDRwSzBjbHg0Mi9sU1dnQTNjbUZ1NkZyWG9Z?=
 =?utf-8?B?NjZCWDcxZVJxL1pKdVZQSGxFMitnc0F1eTlSQkFQMFI4V05TZ3M5OFhBL0R3?=
 =?utf-8?B?RkYrVWp4cFRwSDZzL0hQZjdjNHhtZEJFaCs0UllzaG1YL2dXd3VhT1JCbGF1?=
 =?utf-8?B?SzNJZjNaWnZTOXpLTjhNOXZITGhaZGNaeHdEQzBqMHBtZGtvcEJqU1J5OFkx?=
 =?utf-8?B?U3pUNHFPaUVML01RZjkvVUcyVlE3dnBzMkgxWXNJRUl1cnRxYWxvdEIvSzVi?=
 =?utf-8?B?SHRSNkhSUXVtb0hMb3B2TFowQVhSRGxadlc2TGM5N1pTZWZpRHQ3cVpoUTFt?=
 =?utf-8?B?bEpMZzlWM1M3K1AwTGFqbWJQbUhMcmZKalBqb1NQOVNNbGZMVU5jZXZod0FU?=
 =?utf-8?B?YmVpUEVtbC9IK2t0bS9ld1JWMWowVXJPMGtGQVBRVnhRa085dU5ZL2luNHNk?=
 =?utf-8?B?clYyZm5LRmZXY0VaUzRpdnFnUlV1RzhYdEt4SEVucTBFdFdSUGEyY1VaSmNx?=
 =?utf-8?B?eG5kMmJHemo4M2FDRWpBenBUQWpncmpTZ2lIYUdBZVYrT3d5Y3lyRTdBNlVm?=
 =?utf-8?B?U1dpNndOUHBkRmdHSWxmTEt6eEg4SUtmUjVhdzhWVyt1clpITXJjZHlWQkVN?=
 =?utf-8?B?eUlhZmpoR1JoSlpXS3F0OTFQeVdvazgxbCtWTkVKWXZiRWVVMEN3dDRpUjcz?=
 =?utf-8?B?QTNUNkl2RkM5RkdJU2JZUkJWSmtWR0w4MCtScDJ2OWRVcVhPanFWcXZ3S09y?=
 =?utf-8?B?V1E4aUtxdXV0aEdYZFdJazRJdmVybVVTeGFRbVY3czlxYnl3YUM1YzZIaG9x?=
 =?utf-8?B?RmY4c2VKTUtreFQxelRmaDJLUU9ueGNnODdTZDZKajRkczFuVDBrNDQyWkFj?=
 =?utf-8?B?cS8zdlNKODVjZjYzdEdESzhVRWdJL0RwYXArN3JLN21PSjNPQVdZaVRRZWht?=
 =?utf-8?B?RVd0NTVHcXpJSkoyN2hTR0pyVlJ6cVdGd2oxM0VTcTdtZmVDQ1JEV1lBVThL?=
 =?utf-8?B?UUVxMDRkbTBnL2x2OVczMnk4UjcvNFhFZ1pCeklUci82dFh1TTZNN05rRVRa?=
 =?utf-8?B?ZExOY0NsOFA5bklHQ01vd3k5UEZzOW81bXhPejBudmdDckY4czdSV2h0RTBR?=
 =?utf-8?B?QnJ5U0ZIU09EU3JET0VoWFNRczc3STMzV2xaRnVpUDlXd3JQWk8rd3RzVEtY?=
 =?utf-8?B?RWZCWVc1UzdxNnB2bHpVTEM4OG1RdS9nMC95RkQyb1czeGkyQ2IvdjV6T2dX?=
 =?utf-8?B?bW9kZ0I4N0kyWG5CVEVSQkNjU0JsKzBzTmNTZmFiaUxoYXZOcGhGOVpJNHdI?=
 =?utf-8?B?dDdqWUdUQnJFbitGQlNYVVJ0dEJLTFlYK0w3VWRUL1FPWmc1bW02ZUlFV2Iy?=
 =?utf-8?B?K0taL3B6VGtWS1Jrbk1rU0VlbGxZMmNVanpxTzlleHl0Q1VLYTFiSnhVVTZu?=
 =?utf-8?B?MTNHaHlzSUZoWTZwUHlPdkxPREtkTnp4dTluY3JIWDh3QldKZHp6MDJLNENV?=
 =?utf-8?B?Q3plaXAzK3VCSWtvdEVEUFZ2MUpmVXNBMWtzdjhnQ3BPM0Vja2tZaG5vZVhv?=
 =?utf-8?B?N2x1SldLRFU2cUtyT0NIKytTQnlYQmdyd3puNzFESi91NGFVOXJ3UzVhMTll?=
 =?utf-8?B?dWY1TlloRllXd0F0MFBwTFBJV1QrdkVnTmVKWEpXYXpaQW9PSGVpK0tGcDAw?=
 =?utf-8?B?aExrbTE1WTR5SjdQOVFCQ1hCM0VKS01sZnp2YVJzOTNNZEZlRWQrQnpISzYv?=
 =?utf-8?B?NWZudy9oR2hGamRPS2ZoWm80dmlKTUtQdXFkNTdkc2dHOWxXR2swZkxpTEdP?=
 =?utf-8?B?V1dEVUpXTmxiNkRiSWxzclpmWHBpaC9icjBhMWwrbmpFT1ZER1ZSanlDWmVp?=
 =?utf-8?B?clZJU29wOThUcEdIOVFnbkszZVNKS2p3ekJRMkhZb3NGRjlRaEN3V3RWWkov?=
 =?utf-8?B?d3pJR0Y3RmFDbFNSRksweWZ3RFF0T24xVVU0bjBxRnhIdWpFeTBTK0JNRjRm?=
 =?utf-8?B?WGNNd1F1ZC9Yd05md2gxZ281QVZkaG1PNVJ0WC8yUmF5YjBkc1Jrbi96Q284?=
 =?utf-8?B?YjFUN1NFK3lwRGdSREViaFdxWlBIZlBZNEtRVml1NjNSWnBWdk9YVGxmeWRF?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IQegPRMwecMtIcbkSVDNUHrv/Je633/RuZQOyYmN17P+xUVu/2aRkXldPYONMHR0Leam5STxFBuDfQylhvWdT9PCnG3MlM2fvxRJdD9UlXyt/qz3mHyMSkVO1yQuVhb26wJvh08yKEvTbojjTKOz0Ggg0zUcl5oQAmDzDIMCXWfJruaxhnpsaDja2n1lGRCrLB4J5QsMIhIPMHMOWreVV5zWph6V08cPsHP6JxBL217DVNzAVwtRtD/51HAHHcfrR6O0RWo/f7SHZQFAEo/7fQMTL/Zen/CrKpNDWOvTI7tSvLHLfHL1YKBuGb4q0V15nS2Bl/oXmpiCwjtk8gVmFw2rqKEKbpqHYqRwj22Ze7wzBpF0hOnADQOCqNV/dtrH31LTlZ+HrggqgDblF1lLqpDsWf4gZF+UnlhsyWKKgOSX+55U9nrF6c/QJdPV+oekftaC8Xvlci2UKbCFO1Gu4xFg0oNm8wpI0fEhG0jbN68w9WAKtyOWr98F3eB7TD+6VJpFfihLl2L79bpMJ3U0gingEQVKrKm9yunG15FulsyYSEfC0I8IkNPweips0w00SSVCaSRuBeBA9Rqks0joAAvBCcj89YKpcVtjS2L8zZA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be50a6b4-3d65-4cca-27ba-08dc849982c3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5895.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:23:24.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pdh6PrPUsAXojzk6h2bCfnSPTLn+p0DMjzcC0QXc7DyiRLJm/v9ial4qHHWNGbBte+MYIF6/E6+O1+2ZrpLsmT7n57lEvXmkWmbnD/ADNHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_05,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040107
X-Proofpoint-ORIG-GUID: RrU9zoW4nn5gAQ4GMLiX7iT8PtBMjkD2
X-Proofpoint-GUID: RrU9zoW4nn5gAQ4GMLiX7iT8PtBMjkD2



On 6/4/2024 9:16 AM, Ravi Bangoria wrote:
>>>>> Events can be deleted and the entry can be NULL.
>>>> Can you please also explain "how".
>>> It looks like x86_pmu_stop() is clearing the bit in active_mask and setting the events entry to NULL (and doing it in the correct order) for the same events index that amd_pmu_enable_all() is trying to enable.
>>>>> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
>>>>> This appears to be an AMD only issue.
>>>>>
>>>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>>>> Can you please provide a bug report link? Also, any reproducer?
>>> The Syzkaller reproducer can be found in this link:
>>> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u
>>>>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>>>>            if (!test_bit(idx, cpuc->active_mask))
>>>>>                continue;
>>>>>    -        amd_pmu_enable_event(cpuc->events[idx]);
>>>>> +        if (cpuc->events[idx])
>>>>> +            amd_pmu_enable_event(cpuc->events[idx]);
>>>> What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
>>>> before amd_pmu_enable_event(cpuc->events[idx])?
>>> Good question, but the crash has not reproduced with the proposed fix in hours of testing. It usually reproduces within minutes without the fix.
>> Also, a similar fix is done in __intel_pmu_enable_all() in arch/x86/events/intel/core.c except that a WARN_ON_ONCE is done as well.
>> See: https://elixir.bootlin.com/linux/v6.10-rc1/source/arch/x86/events/intel/core.c#L2256
> There are subtle differences between Intel and AMD pmu implementation.
> __intel_pmu_enable_all() enables all event with single WRMSR whereas
> amd_pmu_enable_all() loops over each PMC and enables it individually.
>
> The WARN_ON_ONCE() is important because it will warn about potential
> sw bug somewhere else.
We could add a similar WARN_ON_ONCE() to the proposed patch. Thanks, George
>
> Thanks,
> Ravi

