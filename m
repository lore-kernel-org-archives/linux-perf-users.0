Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC019884B;
	Thu, 28 Nov 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800068; cv=fail; b=OzCZCOguK1rWwrJA0xe1MTDSvPFaC5RpmYTF++zJi2QPHEOFbpP1fsH0MYDZof17Z7O3a8TSbDTWok3ZS+vrAmX87Fh7KaMtvmv7F2nwZREVpkHva8MvcNhiy2jr3fKv1yc37eYsyfwxazeRd5KhIScd/ZUctuvAVUUWETJ/Rpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800068; c=relaxed/simple;
	bh=v/R0ziEZkwRZMGzfqLSWGEHL6PFP+asID3OKUpz9CCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F7ZRdME4O9I5rMavRL6A4+wUJR/tdw1OM46XbNVwT8Bm/JVVll9NsXXzYfoQ9rlXktNyPDpvRL9vmdK5sZ5hJLLPHCSF/DGi0iFAQLxhXhfaeX7Z6RUPvwiYb9q9ErU2yLZtFK9qR74jpS3JACznbf3LSq4dZ5+JB7RDIRtWezI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cUIW2g6W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sH0S64qi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cUIW2g6W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sH0S64qi"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS3tZR3013513;
	Thu, 28 Nov 2024 13:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=v/R0ziEZkwRZMGzfqL
	SWGEHL6PFP+asID3OKUpz9CCs=; b=cUIW2g6WEuVon3UJnxgkujo0OLV1KYqugW
	GvsoFfoxKp6vIgVMdg7NlgQ+jkM2+fVYx4S5LuE60rFKilC2rseD0C5sSbI/8yU2
	iJ+wGToZEr8Vl92G4JxpdKlPq5DpjfFtUU/LhINxcD/Hu1G9T1IBU0+SAPuqdi7z
	H6F8CYXKLh/a2YVOBblO1VBqASMGD59KeIM1U9ECCbYI3DJAoNABFxuWUh7yf7V6
	ufgYeZADWiXc2lv1HbmkIerQA21M6pwcf/UjfrlOP8ZL/ynmoRkLht12Cv1nve62
	aza6ZUVsVFvTTJgrnoobLKI2tc34pFhM4CDNXN13xPG7nApvIeeQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xx1utc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 13:20:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASCemwL027507;
	Thu, 28 Nov 2024 13:20:42 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43670440jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 13:20:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tK3RpAA+jLNsmlcYCxgQAM9zSOJSebxJnarngKgoos9htbEMYTY7/xWQhV2kNozcH1WvdhRqhM0QFsYcy5D4ECGX+WA6TI4q64gGR5Fzc+VXJr/Ry4CfJ9KDm8jCPcwP+HIYWr8gasCVfBWGuuuDFTO9aTZGAn90nNVbf6IloMDqxHho+D4cb7d3clye6Pic+q76p3LGTPww1yE9bgQOAyVwNT3BjpilZnU2dI//JJS/vHDCAvKWysWVtnfSgvseRV3vC0wyCf7AdOMrGl4NxrcWViO8zryez2OE8aoX2YHcB2T8EqtWf8rXa978OiiuFt/rgsKogv+WFrEC6P+6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/R0ziEZkwRZMGzfqLSWGEHL6PFP+asID3OKUpz9CCs=;
 b=dz/tppGaGBawqT8TN4osFnGbUAtO3Is/rSQgRFfoWqJVJKLUPIh2yNsnRA5DghJq+vD28lLnVs4uU3eosvr2ggiS8o4rAHdBXzEWPwBCDvs6g4BfCDxv8zjzLzw3u6BnAa8VkavofrmLSpzkr74/2xJSaK+pZJrCFiQ+fmJWEq7+t1sTVAftVyVeoRURoPT5CrqEaQMDfqOzB8xrz8m2DCElwZcWIK2ayyckcvKIagziGM8+ThkMXMtYIpIe32ZwEDfJRCtdQ7uj40iBWCGRB7q9rsSbRaffnKKLO0IbtskMlTjy7iEBDB7+TdqcZSDygp0GmneTlfRqk/na2VGz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/R0ziEZkwRZMGzfqLSWGEHL6PFP+asID3OKUpz9CCs=;
 b=sH0S64qiFXEyarBrOhtpW6Kn71zBB4O7ts3VxOxfBQJ98loCNBY77efaRkDTQGRuigOb3w8X6hB6D16BH9412uGXLp+VHonQumPMzpKNvrrrYDr2aqufDy6t+LCtQ51EGmD/e83HYLPXTl1WZEfJY5iGs6Thr+nQ+m6nrLr3Wco=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6505.namprd10.prod.outlook.com (2603:10b6:510:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Thu, 28 Nov
 2024 13:20:39 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 13:20:38 +0000
Date: Thu, 28 Nov 2024 13:20:34 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] perf: map pages in advance
Message-ID: <1af66528-0551-4735-87f3-d5feadadf33a@lucifer.local>
References: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
 <9f9fd840-6421-43b5-9a12-edfa96e067cc@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f9fd840-6421-43b5-9a12-edfa96e067cc@redhat.com>
X-ClientProxiedBy: LO4P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::23) To MN2PR10MB3374.namprd10.prod.outlook.com
 (2603:10b6:208:12b::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: 16cf81ee-d018-419d-5835-08dd0faf72b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d/EsR9wFvfSom21xiAklOy3zFb3L5QhIq6CSoYBMFZYZtoC8lcLnpoER4htX?=
 =?us-ascii?Q?mT/kiIlau4wM20030rWFdzrxCAwH2tY3k4ndVdeA2FrhYgQJ0f5aNg4HEuhn?=
 =?us-ascii?Q?bKtJhs5r+YTN/QHsS8yiJmsQiJmifhwIP5ZCMTCyi99CBOlf0tnEAyyH9weG?=
 =?us-ascii?Q?FOgcwIK7CWPB2RFa/2YB4PDERiQXY2gUgxRHDxKn0umv/3CmRww88O2kZ6bZ?=
 =?us-ascii?Q?fUFhtzkzX7ZRz77JGTk/2c7U1y3cKxCQ/7EG3SBq0mzZWE8V8WTsHmxVidww?=
 =?us-ascii?Q?dVC/XG9za3ZctjWbA21sNqkXmJqUPRc5KvYT7Hm2X/45G0poFewEVGeVT/Sy?=
 =?us-ascii?Q?1+EV3TaejyY7TbINTkpKGluPrWpDVwHy4W0cZvpZz3XikRY5l6ndn0fQXTG9?=
 =?us-ascii?Q?RHoiE6VW83OCF5SqDwKomagHtyd55jI3f+buMazKJv/1a8d76hA0F6eYiSKE?=
 =?us-ascii?Q?aMrAClh+eg+u0u9H391PnGsbQg3gtUEX51anxyBZEhF/7METyQJgxxVsgTlx?=
 =?us-ascii?Q?Q37LWdEWGG08ayuIzD43n2KgLSrubcCAg+l7jbdmbdx+laTSwkNZw9CWoU3E?=
 =?us-ascii?Q?WhI0tKsZUFs1HVFIralx1/pk4UeU+1z7+eW1zKIwUitjcd8qnkSxWDMgLN36?=
 =?us-ascii?Q?aXgZK9bjR5Sl150Zzm23+a4trRNAVdlGbH3gUmT2ygydiAK8XWWQCH9M/I6k?=
 =?us-ascii?Q?Olzq9ea1PbgL8vyFanMArnSDE6PDALp+QuPLRh9/EGX/MyGhhnBzrDhpB14b?=
 =?us-ascii?Q?J+ISUloCK6iNwh5Iui0AGyF+YQ0XF0g9siO7DIsSEA/EGoMxZvc4CQInqyOH?=
 =?us-ascii?Q?H+g41b1NrPkUXWmczVXHZocapKqwLDhe8WPkzm8XY2nZxx49KFScqxrj9ikA?=
 =?us-ascii?Q?S3XEH2acPUZbe4tY29LjK+KoEbBdG2ms8Ukr6djpZ0xjDg/F5sjafYvNN1j/?=
 =?us-ascii?Q?srQ/vudjfgFN7vBb05eVO/z9U1Wost1dpuEoA1w4HsH43b8OXhEJoYATBmfJ?=
 =?us-ascii?Q?0tmv2oHX0BEbgfTUb80OCVV/iB/fGW80PDUIUIrRivgbV+mavkE9/C0ZE6sX?=
 =?us-ascii?Q?NThKkIFEXWXaANaxpH6dpSLhOPzk8neTd2VDQJPkRH4CTIkv1N4UCtpI5fyD?=
 =?us-ascii?Q?2I32HyeJUuwVxQvuhUZRzblWbglcDDzYUQwTCF5xkPdQbQz7B28PMdDs1G9C?=
 =?us-ascii?Q?gQaA54ViB2PESlI3GIRerf7hQ+1rBiifc1QhoDT4/bCKnut1UtGrz53ewETY?=
 =?us-ascii?Q?9U2enFGKChy8Ajymb+WPwv9cwYnn7NQTs5ck3TsdkNnNgy4G4AaPp2PJnw1a?=
 =?us-ascii?Q?XTSHLKbnEc8wTkuEuPxK/7b6xWGMDnT9uDdVonT945DfVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VyHg6TnVLZ/QP3I2KkgEtgOHpJwT8KFPA17/vImVINrSVZhOIjTsLwLx3J1X?=
 =?us-ascii?Q?LUfqiMQRQu3faAe/D5thyIXDjaeNjspJ1v97Tfcy3Y6QvWKRNQsIJCC8CEGR?=
 =?us-ascii?Q?f5Z+RSYO9AI+8qcIU3cZ/PxjksXOHPzVrgIzACg43yAL/72sUnWO84dsx3F3?=
 =?us-ascii?Q?PU5bG9OAKBJjpEZgiLktCvG7jvOA+OdNUk1kJI3tZCfSIJVO/QwMb8Bz6NRw?=
 =?us-ascii?Q?y9mEND2dzzQ1sSog2UEV8OONLWtFcVOpiAV6Fg9Ew0pqBaffaqdPXY86DDEY?=
 =?us-ascii?Q?PRPW7wGeb+jdwKqbC9CrZXSgCN1A3hfkGApAxqtazsLcUZunV3bcyfZSE/WK?=
 =?us-ascii?Q?LZf0Bsa8HRPvtB/9CvKPcHBUUdtroFEaFSkCwjHysrLLqnF6Uuw4zIusV5gp?=
 =?us-ascii?Q?SchOiY3/MdnW2mrFyv9JnGLiSl+gEHSIJFdhFp70QvQNHZeDk8f+GUMCbHCg?=
 =?us-ascii?Q?Nq6Jnn4wbACT1Cl6dRHN4inQ5CtVVEkDgR3xVT54usrfRW8htsFk3SPmk4k5?=
 =?us-ascii?Q?nyLQVz8TU7U9VlqMRLkyeNNQbQ+Xn5SF7GkICY9Ql74ceK6aoSl1lzZHpgDM?=
 =?us-ascii?Q?vpNaylkcX+jPEEAVTYnruV9ike4bjkNCqIO8WUVX7u+oiSqmwRiMMt2FWLe0?=
 =?us-ascii?Q?Z/WW3xdoAGft0p5FCU54TeVkS26slxaYhFg/I4VD7AhUPFeHeHtqMRJlrXwB?=
 =?us-ascii?Q?TQxstdNUIw8dRS+m8JQzmAnqFmP7K/e3P62aqik7FX8IaX0wYbmPZhV4TuVW?=
 =?us-ascii?Q?mQ8zIiLDrpvIYAq5Jrync9cICVsVSRi8Co0YNZeLAG0Xz2mQVtvp80xX6Sej?=
 =?us-ascii?Q?iyRLINIuoDBcARFZxmbx9FpNNBLWB8D34F78VaJj4/9f/7z5IhWujA+fZEkH?=
 =?us-ascii?Q?hRsNegIXc2znhlzH/tncyEm4gPU9zi1UfeBqW06UG5nUIUYyJXJTuCY7EFOh?=
 =?us-ascii?Q?6Y18bg+xBKBv5YdhECkJmMMnmxMUUDAG4qCh4kDqqaYaIGVIx81lF4mWzXbp?=
 =?us-ascii?Q?AYLavjtVh+weqGHADGWJze5lvHJY3VYWehyyN/bRYb3YgH8J7p1m47WvtR48?=
 =?us-ascii?Q?06DO2ex4BxGk1OZ5aVtqK6I9FEnDOSuQox6Zl5Z5edjUTWidWiV5HrgN4LXS?=
 =?us-ascii?Q?MkfmvnKH7rebQLBYAV8sV/K4xDlFLe8OsvNytlLBHUMU8KHSzE4002SuTsSh?=
 =?us-ascii?Q?vMnj+Wt47qF1bxH56h50hpaKytsXhUfdq1oVqoMIPHSSxBbGkysVQeJLkZu4?=
 =?us-ascii?Q?Gj5SetBpCWoqHhhqCbGlQ6crTVOaErJVyCPpX+0SshcMMg6DwvLFl/OFWDgc?=
 =?us-ascii?Q?bxuQSQWTs7k8gdEzHGG5Q9TrVeTHDBvlQ8LlsONIpzURtU18NPBbOpqvC5+C?=
 =?us-ascii?Q?cGVQTftOFXf+4v7GFy+IjIHGV8GRbmThzjYCNjOKcMnNgDtUIGJVjukcESe4?=
 =?us-ascii?Q?Hn5W4GshWL2GFG1LRjXlxfPft8Jg05vq34WEFNiMSLnNcFxmM+u6VCbsA6hY?=
 =?us-ascii?Q?5RMbZagJxpIIJre3v31F2R/lt/nwBpLTMe8XqNhKYjkHVM/uvxKuo/b2k8oU?=
 =?us-ascii?Q?a2T2yb/SsHMSIMnRbAmb0LTannGRyT/1cV52al1xxtjhqGT0CEqyjhbyJntc?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nmr5NM7OMME5ab7daotdMtCzNVY0ISw2a8nQ9SuuWPh4iFnENEujAwXnlLFaUnDv5j+l13+/tAJWF87ltCsjGlQG3YSbsW/UcXoMWmOEukXhs8FSDlClwydtwPDqESR66v0tDFrblNmsGrJBVh5DcSXi0sPfmv/1XiC7wXHXp1ryfKbG2P9csF6V4iI8HELh9BrlYUJz98vPSB3PbHP6wnU9UbWRh6EUHK8hl6b0aTZfUc41P0UPx8RXY0WEGF2+v6JnZK5BM25RxW8xOVNGrtAmnfcahATgnauYf7aFPEH0IQhCVY8gjIQL85ohzNoTeq7ob+KSpPZ02IzzAhLmPPp+2AxB4SXXhURmRXRjC145jDeEDg2LI8uHLgmnThxHPftfkikSq4aKD8ATkFg5gsRhIULiS/KOGs3YMlREX8DN7ouHbuB1KJXRlyab9bLkCv8sRdxGRgISq+ejcI7mARZ0o+rFqDHNY1Mf/N4MqwihSSYAzaWyPnpc2ZMKXVOplt6HkbrsdHpzbsSdjnC2/abt/y/tOwl7cFku4zyzeXK4szX4VgzFEP7d1bwZd4yGjCpBrOZAILXHkB3BrT+7FfYFhlCHNO7fxWAk+qhFDwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cf81ee-d018-419d-5835-08dd0faf72b8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3374.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 13:20:38.6634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BC1Ibuio5jYCGYxHp6o8/d2BmgdP1DiaGERc9wLEdap+iZbu9ggwzRxB94RdtG+Wx4sqQFCTLzBXznbfIOWdLXH1dmnu46T2CegfeN5BpPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6505
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_10,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411280104
X-Proofpoint-GUID: LZzApU466pCEpfbS7IxfQ2HPM4iLhETj
X-Proofpoint-ORIG-GUID: LZzApU466pCEpfbS7IxfQ2HPM4iLhETj

On Thu, Nov 28, 2024 at 02:08:27PM +0100, David Hildenbrand wrote:
> On 28.11.24 12:37, Lorenzo Stoakes wrote:
> > We are current refactoring struct page to make it smaller, removing
> > unneeded fields that correctly belong to struct folio.
> >
> > Two of those fields are page->index and page->mapping. Perf is currently
> > making use of both of these, so this patch removes this usage as it turns
> > out it is unnecessary.
> >
> > Perf establishes its own internally controlled memory-mapped pages using
> > vm_ops hooks. The first page in the mapping is the read/write user control
> > page, and the rest of the mapping consists of read-only pages.
> >
> > The VMA is backed by kernel memory either from the buddy allocator or
> > vmalloc depending on configuration. It is intended to be mapped read/write,
> > but because it has a page_mkwrite() hook, vma_wants_writenotify() indicaets
> > that it should be mapped read-only.
> >
> > When a write fault occurs, the provided page_mkwrite() hook,
> > perf_mmap_fault() (doing double duty handing faults as well) uses the
> > vmf->pgoff field to determine if this is the first page, allowing for the
> > desired read/write first page, read-only rest mapping.
> >
> > For this to work the implementation has to carefully work around faulting
> > logic. When a page is write-faulted, the fault() hook is called first, then
> > its page_mkwrite() hook is called (to allow for dirty tracking in file
> > systems).
> >
> > On fault we set the folio's mapping in perf_mmap_fault(), this is because
> > when do_page_mkwrite() is subsequently invoked, it treats a missing mapping
> > as an indicator that the fault should be retried.
> >
> > We also set the folio's index so, given the folio is being treated as faux
> > user memory, it correctly references its offset within the VMA.
> >
> > This explains why the mapping and index fields are used - but it's not
> > necessary.
> >
> > We preallocate pages when perf_mmap() is called for the first time via
> > rb_alloc(), and further allocate auxiliary pages via rb_aux_alloc() as
> > needed if the mapping requires it.
> >
> > This allocation is done in the f_ops->mmap() hook provided in perf_mmap(),
> > and so we can instead simply map all the memory right away here - there's
> > no point in handling (read) page faults when we don't demand page nor need
> > to be notified about them (perf does not).
> >
> > This patch therefore changes this logic to map everything when the mmap()
> > hook is called, establishing a PFN map. It implements vm_ops->pfn_mkwrite()
> > to provide the required read/write vs. read-only behaviour, which does not
> > require the previously implemented workarounds.
> >
> > It makes sense semantically to establish a PFN map too - we are managing
> > the pages internally and so it is appropriate to mark this as a special
> > mapping.
>
> It's rather sad seeing more PFNMAP users where PFNMAP is not really required
> (-> this is struct page backed).
>
> Especially having to perform several independent remap_pfn_range() calls
> rather looks like yet another workaround ...
>
> Would we be able to achieve something comparable with vm_insert_pages(), to
> just map them in advance?

Well, that's the thing, we can't use VM_MIXEDMAP as vm_insert_pages() and
friends all refer vma->vm_page_prot which is not yet _correctly_ established at
the point of the f_op->mmap() hook being invoked :)

We set the field in __mmap_new_vma(), _but_ importantly, we defer the
writenotify check to __mmap_complete() (set in vma_set_page_prot()) - so if we
were to try to map using VM_MIXEDMAP in the f_op->mmap() hook, we'd get
read/write mappings, which is emphatically not what we want - we want them
read-only mapped, and for vm_ops->pfn_mkwrite() to be called so we can make the
first page read/write and the rest read-only.

It's this requirement that means this is really the only way to do this as far
as I can tell.

It is appropriate and correct that this is either a VM_PFNMAP or VM_MIXEDMAP
mapping, as the pages reference kernel-allocated memory and are managed by perf,
not put on any LRU, etc.

It sucks to have to loop like this and it feels like a workaround, which makes
me wonder if we need a new interface to better allow this stuff on mmap...

In any case I think this is the most sensible solution currently available that
avoids the pre-existing situation of pretending the pages are folios but
somewhat abusing the interface to allow page_mkwrite() to work correctly by
setting page->index, mapping.

The alternative to this would be to folio-fy, but these are emphatically _not_
folios, that is userland memory managed as userland memory, it's a mapping onto
kernel memory exposed to userspace.

It feels like probably VM_MIXEDMAP is a better way of doing it, but you'd need
to expose an interface that doesn't assume the VMA is already fully set
up... but I think one for a future series perhaps.

>
> --
> Cheers,
>
> David / dhildenb
>
>
