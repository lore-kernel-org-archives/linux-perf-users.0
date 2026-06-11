Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEFC2D3EC7
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200942; cv=fail; b=mm/R5i+/5q+w3Pc0d6bcSIJJNW8T7QlV4tkmJ9u40KkSwXkPKVQ0mEa1bN77xmLNUnVC7omB98w4i31dt5HHOXFrBLZjVWF5yIynXZsUb2DgvvycKRsvRxVfgfX6JUpkhK1qjDFIIm+s3td0Q5UbhZESfgens6ZWgvEXGMAqW4I=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200942; c=relaxed/simple;
	bh=ETOgod8QI3ID6IKaKvCrYI81u+OsBLfoKF8+EY2ze1U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cb5FFIHUDWq3GUPHsINuHQ5SPFsUjEM6vNcZypA1NOwTSuzRbPodD63ueK0pUP+gxLKcKlw+n+LX0HkxTtKqheNSJbez5dWC8YIzI0Tm8Ai81oRRYYvaIJKPD9BQaORwNVqCiBn7y2wU3EZsbyFX7c0hFphdMzvSlJtQWtPkHHw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RsOYg/iT; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RsOYg/iT; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RsOYg/iT";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RsOYg/iT"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fqModRsA8XUAX1WaO3xZhHrHOQ0PFPQnT2nHqPrSUq0yDj1SfoWAOgpQEWFyaJrt7fBDlwI9IznVF1PW8tfQ3HjHih6Q7NtgqgrzRLPrdvY4GKFyounA/5xb/vfsqkzUGlepGycTehNQgXjubCQiiOYkPTtJ3UsAJC4ZflVCDqUnMIi9GzDhRBfZU6T8/GRafG87osaE0rwGDgOYItzSe/hkZBBzCANgI7c7Usca1ddPk9e89hgUjgQVXVPfXzda/qO95JAv9Q0kUkSKnt31tKDwWCUE9uKblTe5w+rt9RtXPjdjsEEkwMjPT/9jrFOWtiDO4cH8y5QXpLnMtzUmbg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1MCUYIyiFtg4j84tii+z5rKxuf6f9VUKgD08KmE6ug=;
 b=gm/tPpW4wuuJm4KmKh1LUNNKvjnO9FUeclVoSc79aGx4+fk42Dxp7G3rs80bf9vbJTPrxTY4Z3uLjy+XNF7z0OSl6BxQzUErjVNXRRFBX603qrR7bapDkH2iZORW7V27X/Lgd51bitySn65rg+pPcxZQ9RxaflTvP40zCSYPYRPcmnoYQ0JccJ71z+WIVl3xxKqkbu1YZMhkfmkHBuzmFoOUNSwBK9EF8zqTl6qE0kb/PL4qCGs5I5fNlNccBOPOxRf+3Na0t3L8enBZEc9NKxEeUxZ271UboX87SN7+p1oIpTT7ErYeHj+XjNnYW8TCSOgzB67kFi5DEKN3FGniKQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1MCUYIyiFtg4j84tii+z5rKxuf6f9VUKgD08KmE6ug=;
 b=RsOYg/iTOtASoDncTJ9ukbhZjT99wfVq2i9jdylvlp98ewXdcSxWD0F36NPBevMi+J4P/I3QHgO4rzJG3qxd+ezE9tlBSrA3gHDxB2qoEdTUix0JVwEEC8LlMf1ENxun2RrFfsMdx0ocGXoiQnfWf/lLwqnGWJqyXTw8OjvnlMo=
Received: from DU2PR04CA0276.eurprd04.prod.outlook.com (2603:10a6:10:28c::11)
 by DB9PR08MB6492.eurprd08.prod.outlook.com (2603:10a6:10:23d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 18:02:16 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::3a) by DU2PR04CA0276.outlook.office365.com
 (2603:10a6:10:28c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 18:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7 via
 Frontend Transport; Thu, 11 Jun 2026 18:02:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZ1KAlgmO3cYUN75rGBhMEcT1WRSU6Crjj7tam2Qit/wn5kFx4P9sHNISj+mvT/tvhKOBVysT6fvB6UgfWosBxo6kBo0Zad60r9uUQTVVPWM7/mBcoj9rceqBh+c9hLzVRTy/ykIfKocw/14jhwcCIdaUDf1T1Y+pBAuc8V2vRNxmAn2x1PmnbG1rRmzArif7wX4cEDTeg8+/OVGCDovgKRbpG+3irMonlqIxoLT6W3E1OsUc1XLXeHhrTLMR9HNxkGgcVDmEPKRIoRi1sVMe+dmbz4wrhKYCT+PKK5sjuUkdIJijSVIBgHqHmeyOIUphI8RNhIED9RKrwzpaJ3HjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1MCUYIyiFtg4j84tii+z5rKxuf6f9VUKgD08KmE6ug=;
 b=OLENpwz2ll0GQSHxYMBYNmTRkVlOM+TPpLoyMf8x92Xs1NxKFnLMp2je8nMlFHlkAzqvzJh4Bnt6PtVeNGlM5S7mDoGtoetDCtnt3TQSZzd+K7kuhVe/EUOaj+qELCHY+LcQXVdv906hrSIVdFNdCU720+dIhmzrG6ZrPiZxZdoZfVWmwJgtU4ENuFR5gO46hIaIAKXPq+E+xy8H4WptstHh5iNAiAjUN/2pIupf3KdDUKHkVLJCYUhnd0dBe+3lkZczpP1I5i9oMN3h+JmecCJU4/v4e6yUJJeOhq0JSE9wGDTWOEgg5Sz+dzBSXsdPMTSC1GUgaqeN7k+BtSkHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1MCUYIyiFtg4j84tii+z5rKxuf6f9VUKgD08KmE6ug=;
 b=RsOYg/iTOtASoDncTJ9ukbhZjT99wfVq2i9jdylvlp98ewXdcSxWD0F36NPBevMi+J4P/I3QHgO4rzJG3qxd+ezE9tlBSrA3gHDxB2qoEdTUix0JVwEEC8LlMf1ENxun2RrFfsMdx0ocGXoiQnfWf/lLwqnGWJqyXTw8OjvnlMo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM8PR08MB5697.eurprd08.prod.outlook.com (2603:10a6:20b:1d7::24)
 by DBBPR08MB6315.eurprd08.prod.outlook.com (2603:10a6:10:209::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 18:01:11 +0000
Received: from AM8PR08MB5697.eurprd08.prod.outlook.com
 ([fe80::1578:61f0:5e16:68af]) by AM8PR08MB5697.eurprd08.prod.outlook.com
 ([fe80::1578:61f0:5e16:68af%6]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 18:01:11 +0000
Message-ID: <586a15e8-4316-4dd1-8ebb-063ac07836da@arm.com>
Date: Thu, 11 Jun 2026 19:00:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/8] perf cs-etm: Flush thread stacks after decoder
 reset
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260611-b4-arm_cs_callchain_support_v1-v8-5-737948584fea@arm.com>
 <20260611150637.846891F00893@smtp.kernel.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=0
X-Identity-Key: id1
Fcc: imap://leo.yan%40arm.com@outlook.office365.com/Sent
In-Reply-To: <20260611150637.846891F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PR3P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::25) To AM8PR08MB5697.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d7::24)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM8PR08MB5697:EE_|DBBPR08MB6315:EE_|DU6PEPF00009525:EE_|DB9PR08MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: 7daec435-acfa-4940-fbf2-08dec7e3928f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|4143699003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 jIyjjlrfqYHH34NEGeyLvVdi9PNU0ya7Bpt2BAADb/izPb3hn27obdyE3alZJGY4z5IY9TGigjZhdcORPBjH+idhzyI00/CmuiFWok3M3ZPLLJifnCWbA1/VvFVdTuJZO+uznJXOAq06ti8Bar+QtzVrr4FF3/OtWxHrgRLAiY3tP1n5lGOOjta7MjeND8qbJS3imQ4xfiVscIjI03FtYygLqeHY2sX9II/fRoyg8+rWIhvPqscmitlBTi6ArVe3XMYh7p/hlmcUZPl2nQGwSsnXgSLtOZ6UWALbNB67qpXT+HQjr/aKYTxlQ/NKdbxOS+vT/kpUkFu/NggGhl8JyloDfnulqNZbC2+DQlp2WtVB2YvwHvDxYoex2xq/29nmbNhohimoADZZC2gQrQ0dbxhhXrsiN2wgmjEFlcoVNJMeD/HViggvW21bYdDq13d925Hg6wMIBjliSJtNOh0ufdQmgA3zxvg00VW3a2u4sHA3pcoan/9+3SifOgOnOVysm2M6Elv192la7bJzrAZamhw/myyFNFOZUaNxt1MMKmCxuJ+L4L+yH1ed+MEVC/zFjH/2idOj84LD6RL1Kdmgf9ykjNeBIVClYlarlyrbwJRLqmQC4zNWJkErwsXzLB+D6Gvl+bwLNeGCcEuJU+dhILLCRtOt1wrojnw9d89BCkAu9xc+2YKoH4dd7IlUdduO
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR08MB5697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(4143699003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 hfmM8cAXJRKcwXSOYmgq1exQCwYn7d/8zW3F81GolLvSQ7dM8qzTpfihwifwA5BONcDjVVIRPKVd0Ox5+UamBPmyIKNkbnVFBFWPuJf4FefZ+AuEzG9Q2ze16bNozK51SO7/ts/816P7HD3GxpKaLDExseZK3+CFwX41qnjH88rojsfpmLhv/mhgBFEW8jJhGnE6ICB7+AK2OURgqxJUB/1NIZkNXr3rjoKK/NV33D1filN99c0kztULyq+RbG5FNrYrvh5MeiqIeOYMYH0q8utGBMWWJJQvYfA3rpf0vuyV4a1V7SFxDI8BXrrhTvTdiaZWd/lpivwPd2f81WsC0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6315
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9e912a21-cc43-46b3-1e23-08dec7e36b8f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|35042699022|23010399003|82310400026|1800799024|14060799003|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kVjYQgzwI5jfO9jjy7THfBBrSSCM9TYcXZSXZUBnqbUGO3AcxMQIJL6MblBiAj8IS5E+fPsnlWgmLrxyKyY0R7T7XI8YCifEzscim7TX/Vcsdv1PUP+s/R990zhjumHJb2A2J5JhDuXhshqSUEi87hEq2SEwHdTP6J257Jkwsza3d9E1ImTvrzDlux0zWYkO+Lc7vOdwZYbnokz6/eJkFOIaQ4KuKjkMQ4sh2r4r0Hvfcetv4OeNFZcRxpI9P4qSzgAFsZl44xmrA8BjtA4BiFla56U6SElpBiXy0gZFL2YANKRp0nLLDvpMLKKKlSA+Yoopd0PNN/FRJE9T6NrSjg3MQhsiNXKtxkPK7wszkb2MsYSUgq6eyuQl35SQd5gJfRF5Hpg0DR4RXlgBRi09EMzIgmw7NEUsZlatXJlui+PV/6EwZ3JY7h/uP4KQBOPvrVhImu0fCUSZCBgNQWwEihmzV8bx5iz2I67HIwopH7KlwOf9pWlNuBQDAnnmgIUiKu4w2IVUUiI46tp0w7btF3qQaiyZQKCHjob0eQ7U9HWgPOfoBy3hOjKgap5Y20c2HRoZ9Y39htrKF2yzFszT6+ioffSY4+bxbzgW4lPy3kyUOG1CjbBa3Ue2yt9yIrkFaG+7FZywrXbnaC6TIL88dVyN395mwUVBs+oNljI/m8CO5hhhIp08w/kQajITIMeg5r9EAHYGokrAqAioOPBXLoWNHdoLFhuUr4LQyfTBVjA=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(35042699022)(23010399003)(82310400026)(1800799024)(14060799003)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3jd5wflImzD9W5r6hcrleV8c7msC87WIOu/+gvvXe9VQBH4GyZbdJEYLblcnm9tfaEb+/M+ZjTBptNUd78Hsbn/4tsHuHCDkB1g6LAmHj54ABIkm23rH3PXFxHo1m88dYHarPwCbctna5BsqznUXLIKFhL7EyYbPOpVyFA6xNWC0f2jM5YFOU0vKW2xsCDALdje6Y2lqeDI0+je9hA1sDp4iJ9ZQ/b7S2SY81i+zLYD1gEdK94niMWAL2ksbwnu4vpEmNq6RZ0DZyIq4NwQWkjAzWGT3lSg1ZXuJbZSBuzOe9JRHPhOgWmxmBtIweqxPOYVx+8ZWs8rX7Gi4V0mraI7u+id3SROkHzsDYq1ak3nDOo96if6gk98SiiH1pZ/iiUDkmUy4Bk7iIgvtLgV5TeVkopotJdBVof2W/nnmISCpTMd/7bTQOFRLsLX6wmW2
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 18:02:16.3139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7daec435-acfa-4940-fbf2-08dec7e3928f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6492

On 6/11/26 16:06, sashiko-bot@kernel.org wrote:

[...]

>> +static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
>> +{
>> +    enum cs_etm_pid_fmt pid_fmt =3D cs_etm__get_pid_fmt(etmq);
>> +
>> +    if (!etmq->etm->synth_opts.last_branch)
>> +            return;
>> +
>> +    cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
>> +
>> +    /* Clear the guest stack if virtualization is supported */
>> +    if (pid_fmt =3D=3D CS_ETM_PIDFMT_CTXTID2)
>> +            cs_etm__flush_machine_stack(etmq, DEFAULT_GUEST_KERNEL_ID);
>
> [Severity: Medium]
> Will this leave guest machine thread stacks unflushed if the PID format i=
s
> CS_ETM_PIDFMT_NONE?
>
> When no context IDs are traced, the fallback logic in cs_etm__get_machine=
()
> assigns EL1 traces to the guest machine:
>
> tools/perf/util/cs-etm.c:cs_etm__get_machine() {
>          ...
>          switch (el) {
>          case ocsd_EL1:
>                  return machines__find_guest(&etmq->etm->session->machine=
s,
>                                              DEFAULT_GUEST_KERNEL_ID);
>          ...
> }
>
> Since the flush here is strictly gated on CS_ETM_PIDFMT_CTXTID2, does thi=
s
> skip flushing those threads and leave their original stale call/return
> history unresolved?

I will refine to:

   if (pid_fmt =3D=3D CS_ETM_PIDFMT_CTXTID) {
       cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
       return;
   }

   /* Clear the guest stack if virtualization is supported */
   cs_etm__flush_machine_stack(etmq, DEFAULT_GUEST_KERNEL_ID);

Thanks,
Leo
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
