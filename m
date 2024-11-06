Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023078.outbound.protection.outlook.com [40.93.201.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A9220E00A
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730937103; cv=fail; b=iZMJWY1VR6EBpmAmJaJIAMfdk51V7lahVEvy1VgDjV0i8/XR39dVUhGCOkq38yrlEP7gbiEIwrFtDR9o7mPOVN1AG0g31QtLqSkc4hRkrhtAVUF6AXN5Z9uj2ypxN0mqmIieppL8eooaIWA6QoEEpK+ikvX+g6QMXcCLlHCh7AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730937103; c=relaxed/simple;
	bh=EBVs0WLSiw6US+1mhwosq6C5MnmK6QrZF2xCl+ogGyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I5A7ffSgUcGuY8QudwyZsb085wpun6zPJMPEJjBCqEy3i756Ure9fhHC8/yAJ51jH3mQuFi8JcX55YvpinARWc3HqKIt+X7dfQ8mcO04ycKrVEM77e5SLUZff/y04DVZdESvT1/BkcxRtCvJ0UHkOgHjsQ/jo7kmYrl2Pncpnp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=h1nLQCv/; arc=fail smtp.client-ip=40.93.201.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="h1nLQCv/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bn0qfCOaJhE7+U4UuckJMpQ28iz2Y8VWoyoqc4BurJ3olFl4k4ftf8cky/JfWL3LI0Sk3y3FKP6pcAl24+2G4otbVhTnuibUTmvV8btlK0caCFd91817cRBRFoTda5FMY2m2EIZwlIuqXqeZJs0e+ub9flLJSNwHvR0pWSlXUU427rE0Lp89gc9BsWCwFpUGrbkL1uj3asZfdbQ9uqVRAU+f/TcKflNfx7wruKTJTtmNgnx4BekatmfKU/gYIxvHVIRzfW9ByWKf4/AHUy1Qw8rTAkdwaLrSko+dBLVf1HkBu70NQjQtDWHlIG9fX5Gac1sYv+D+iuLP+3mL2CmDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OV6wATzIZ1H06StfzxkwFU92rSyzpR0ytiUge1qIwDY=;
 b=tHk93Nvkq2ydrGJ9B2buk5XDCtWkX8kj1ubFysz8caCsgifI2eruF3ToBrAIYzmBEUnH5V8iFosnLDnpkhSjIdKUevYg43rO3ub0jlFiEO/cTf4V68WNB96zK5GXzNFK80JHsDvtKHI0Rwhy5MJoRDffuhe9uloQj3yf7Dt8IENzp0z6iCGNzc/8CHreyZS/eWUCqW/N6CpcRttc3DiAZ7/jMYbkQMpCzHxLV51jSILv7hRxJgFoY+aj90aNIaNf8ys+sNxrLMTP4WOXxLQK0WjfaIYlgxYiBAbuhwX1VIXEvmo9K5oH3uQzycPRtQSRyHYv6UaMO8NV1laOeMMu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV6wATzIZ1H06StfzxkwFU92rSyzpR0ytiUge1qIwDY=;
 b=h1nLQCv/AtjbGb7E3uIiDsiChNSjc6Dhpbe+F/YpyRU3Z8s7b3xTc60LXpcRVDV62TQX2cH9HAmdq+ZAUhpDFM+tgmQZUvE3qQGu77/qWwKjKGYBqJcZo8fiwEvK4wYLsr96dke0GvNOFfuu1uagTV0Hgvsnd/k9Fbtpq1Jcqhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 LV2PR01MB7549.prod.exchangelabs.com (2603:10b6:408:17f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Wed, 6 Nov 2024 23:51:35 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.8137.014; Wed, 6 Nov 2024
 23:51:35 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	namhyung@kernel.org,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V10 RESEND 0/2] arm-cs-trace-disasm.py/perf must accommodate non-zero DSO text offset
Date: Wed,  6 Nov 2024 16:51:11 -0700
Message-ID: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:610:59::32) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|LV2PR01MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d11860-236f-4740-fb57-08dcfebdf2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?77qHiG/J0eoO2uFa3TBqahWalYvgUt25GuOHlJWi5Zod3TaQIiXSlb8IBKpN?=
 =?us-ascii?Q?q8dJmcbnRlUdeUTW+fojnTxbOEE3CSh6CgfRfCGOOWddHqhtMJgED3iLR13G?=
 =?us-ascii?Q?1CDm0FB7tM827yh3EM/bT2/M04dxO/zrrx479O+FnXCxGysNvxRLgr3LSBOt?=
 =?us-ascii?Q?Ebv6qmm3WWeHvszZdvxgmLT8mssLM2nMheopcaV+zE6a3TTUboLmIMWw7RP9?=
 =?us-ascii?Q?kX3LxGD2qwPDttwBDsLe94Yons+ir0DzD6YHyl7NraJdCqYdxWv7MjpAxr+v?=
 =?us-ascii?Q?OF3Z4LO0YRfx4OtP3pq3wy2Lyk4/GNM18U4/RpkdTu76frQ0krSeX8fG5ZhM?=
 =?us-ascii?Q?DEfBXw4xcUmU3Sffds614YET2zIsBso6DkPTpZA88zt+ZJ+WZNE8mXYpE1Dr?=
 =?us-ascii?Q?1VlygwlaHopt7/rcfxlksArLtb6p06q4LKORPStNCrqeaqsblDvXp8MmqT9S?=
 =?us-ascii?Q?z1pcA+MvJW/f/UuJdUlWJoHa1nLzJC1hdH/veLuw5aBC/CNuQO03oAqoZOnT?=
 =?us-ascii?Q?bsJ7hRBiXFFp23c1AnfGBSkHfTDd2xwvaLs2MeYHgIaKiMdlyxepECxBA3md?=
 =?us-ascii?Q?sYoKfPZ01ynNov6hB/GxuHPb1N/Ltz81Wf1W461UGuOaJyZ1tNuONWc4rQd1?=
 =?us-ascii?Q?QZnJMCKaD2rWLCd50fu61eCvBz3guI41YkJfGSkZ6uzCwWNnlZwBcxpnDYlg?=
 =?us-ascii?Q?q8LQNcwoJfBNpHI5bHqRldCJW+HW0Om+r6v4ivrLq+1ZSEp0XPCtZwe35kZk?=
 =?us-ascii?Q?UbA1wP7lF9kRyISCRPZuuwiHju2nZr6i7rajv+18lXr1k+1K2u3A7yoMdEHS?=
 =?us-ascii?Q?GVjKsra/F7DIw8jrT2VaFy8wXKBIXtHXUAnFZkJ+UAIYN0PjwTTimwHdsSe8?=
 =?us-ascii?Q?Lb5ASBo1WbFeEilMXdt+6l6p59XSOaX4/6pjMhLEfquoPV8ZKp8qPDMNb1DM?=
 =?us-ascii?Q?2tgo1PDg60IxBUKFKRHn4ai2LsQUvdG+cuwH3I0kOUwuYCF6RHxpVuDHbrOh?=
 =?us-ascii?Q?0hN3+IeWDLk63smfexxQrxdI7ZdhuxRU3eV7RKFxquHLWfLg0K3jGX+rr/W5?=
 =?us-ascii?Q?4cGoS3z8QO13krvBYQxLusC8cpXUDiEUSAp/iTU1TldswidEOXR51ffvR9TL?=
 =?us-ascii?Q?fVJumVFzpzt0qXQC02wN6N00LFLe7OhNqxiBBN64P55DO5tOnc9FEGUYDVgS?=
 =?us-ascii?Q?zYadqsomWkjrbIRTb9VVajGagmXNDshK027Rj6koHeL5hFB3Xo4GW8ARw2Lu?=
 =?us-ascii?Q?2/WM1cUwysm1rlYOn7czm1jvInEoG3dU6T/4CG55oXII2gsszAJn2e3NdKiv?=
 =?us-ascii?Q?T2eeh0azX74KtNkfTBDR49Il?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rhf1a3Ctl0ruDYvDc1GEE/WEqbVKZgmmDTUK3jjCRksTYWz1Z77KUwxh9e/K?=
 =?us-ascii?Q?zZtTHs1CmifQItzLpmEkvlPMGZCp2CUuV89iMQAgVLHMGUGaqLMMWU5MuX1c?=
 =?us-ascii?Q?OKBiUUSK/RbdGRYXAx2G0oXCOQIvSwcLNpLF2LefdMzw0/oBJbN3BeECbml1?=
 =?us-ascii?Q?iwXeCaxxZ0n03qSV4apRjKRSkBa42r8tl8vB+H8XUpqiJWsDAIfwrJ7Q6HEe?=
 =?us-ascii?Q?EVHob/w6YQhExD69Xq2bCyX4iBv5P1OPb5XjUen0sOL1ZrImCXj/OMYiZnlU?=
 =?us-ascii?Q?VJjagNUmBiBZ+qF30jw6ijdzoFEM/mHxcMyMnYAq3uN8zX3XhOGSP/xYdivz?=
 =?us-ascii?Q?GYSjhVm6jvxdY+UfKwFKt4zGNlf74jZM9R6NTzkH2ZwH39XnV1q0jrwbozuY?=
 =?us-ascii?Q?wxLFDvSlr/TLOo9YzsSQx4YhI3RUm+nO1XwsJHfdCtz8gMGkwXtZHlQgOxnf?=
 =?us-ascii?Q?p0VYRMSG/l1+4M7bDy4dBF1D9xHhPm7nqt+mSBGXHZGXelC+ZNiaKVLwphog?=
 =?us-ascii?Q?cvyntvcYm91+FqZv8g7bp7MGFEyJgX67itP2FyNGB384cfVFPfyHrfv7Zt7A?=
 =?us-ascii?Q?oEQbURLaG34pSvnoCi+MTw/fusAq7g/4Xq5VnFyZ4IBBOXyLBGPISCEMxDbg?=
 =?us-ascii?Q?jnhir3Kz/NpmRKvw6M+bQWj/r8KdK4ad4WrD833WJhIy3FOQxuhqnbMObXBH?=
 =?us-ascii?Q?729YCumxB1/HNJTeTWKpRTct74QsVQFQNlPkFCaUY5f6iuCeEzkfcR7xkKv1?=
 =?us-ascii?Q?ODBNJbZJ1mVkBPLv5lNrZ0T2AbSkPfuMUaMnIDKdGJ6CZMdBhwKrN9m0opVi?=
 =?us-ascii?Q?rnV6MSFaGxuiwHrFUhtiFIlJQiugYgGwe8olabtVaHIfg/qzh5ji8ji9vBCB?=
 =?us-ascii?Q?pVkFKdPZB3m5R1e62kC4RqAEpIPsCpC8SaG2hJeHwRQmh8LcSDR/GZ5ve3bD?=
 =?us-ascii?Q?84qWHcsHWhtrMSN0I2ORmjXFKWieR9GuLkOB+GiWBel/ZsG6qTzCpLgfjLMR?=
 =?us-ascii?Q?SLEHZbzTl6aNpmj5TnZK5aCkz9HWE2Ema+rR4mrZDckkdqukrzfI+nVmOWkh?=
 =?us-ascii?Q?2sGawht27ymJpHGsTrHWCiRBKr0a1BXHXGIdtiwHZFq/YE1kt6iTERqEUCmp?=
 =?us-ascii?Q?Rt7OXtzu8J1CJ371io/SjorbjZJKpUwzHR9xmEgSdw9C0Eq0yB+hKkZo60j5?=
 =?us-ascii?Q?WqBdhSsEo7cKsL7xWNZjnMWu3J9kEKvcOp2IAlUpPSpfZpBGxtOIPw+AqFBg?=
 =?us-ascii?Q?lhMGe+jLJlc1FO2gvM09x72hZK093wyFpurhI8DeuuBpak2uNHmTAvKFb0Zp?=
 =?us-ascii?Q?1LnJhtn+m5IxsYMcJk4SAJNeJ678EPMpN7ucLOHmQ4KargIQ93glE4t4+qgy?=
 =?us-ascii?Q?oz10EfEyhNMOd1432HKxLBgQf4QuxIPnN4yd5FXP2Dc2ZUziewX9Dh4Sltxp?=
 =?us-ascii?Q?nhbBTSExjvq1ZYPKp/4ngaQu7Md9NeDvqEXDX2jVU7YSqmQ8EsX4uTgZampJ?=
 =?us-ascii?Q?IaqZOA9safiOgLi7HYljWPBlPBNvqAbNOgvde997km9qG8XoXE6aDhPem6/w?=
 =?us-ascii?Q?fdkqnjV4TYaa2Ag/+n6PWSpVVBtGTySz84fgEmjQDam+WNxYLr3b68st33mT?=
 =?us-ascii?Q?YpqFFzH05u1na5Z5Pz0pEvKYGNrvSroA/rn2GbzF6QCg?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d11860-236f-4740-fb57-08dcfebdf2a0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 23:51:35.4088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVaquLh9bwADfvTRGtsMzLzwbMiUZWRq7c35XGwcflJ0WtUtxCak5vY2CsgNNkcoSUiHkfV1qjk9mYiC8DTIj7JrSFafYaW092ovDtudsDD5sg+crUr/LjCOx0OO9CoP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7549
Message-ID: <20241106235111.m61bjvC40QRhC6vS6dSIk-mW8FPShm9jGpKzZQfiBYs@z>

Changes in V10:
  - Removed errant space in patch file 0002. Passed 'git apply --check'
    at perf-tools-next, 6.11.0-rc6.
  - Added back missing prefixes.

Changes in V9:
  - Removed V8 patch files 1/4 and 2/4.
  - Modified set_sym_in_dict (trace-event-python.c) to add map_pgoff
    in dictionary as-is without regard to MAPPING_IDENTITY. This patch
    file is now patch 2/2.

Changes in V8:
  - in arm-cs-trace-disasm.py, ensure map_pgoff is not converted to
    string.
  - Remove map_pgoff integer conversion in dso not found print
    message.

Changes in V7:
  - In arm-cs-trace-disasm.py, fix print message core dump resulting
    from mixed type arithmetic.
  - Modify CS_ETM_TRACE_ON filter to filter zero start_addr. The
    CS_ETM_TRACE_ON message is changed to print only in verbose mode.
  - Removed verbose mode only notification for start_addr/stop_addr
    outside of dso address range.

Changes in V6:
  - In arm-cs-trace-disasm.py, zero map_pgoff for kernel files. Add
    map_pgoff to start/end address for dso not found message.
  - Added "Reviewed-by" trailer for patches 1-3 previously reviewed
    by Leo Yan in V4 and V5.

Changes in V5:
  - In symbol-elf.c, branch to exit_close label if open file.
  - In trace_event_python.c, correct indentation. set_sym_in_dict
    call parameter "map_pgoff" renamed as "addr_map_pgoff" to
    match local naming.

Changes in V4:
  - In trace-event-python.c, fixed perf-tools-next merge problem.

Changes in V3:
  - Rebased to linux-perf-tools branch.
  - Squash symbol-elf.c and symbol.h into same commit.
  - In map.c, merge dso__is_pie() call into existing if statement.
  - In arm-cs-trace-disasm.py, remove debug artifacts.

Changes in V2:
  - In dso__is_pie() (symbol-elf.c), Decrease indentation, add null pointer
    checks per Leo Yan review.
  - Updated mailing list distribution.

Steve Clevenger (2):
  Add map_pgoff to python dictionary
  Adjust objdump start/end address per map_pgoff parameter

 tools/perf/scripts/python/arm-cs-trace-disasm.py | 16 +++++++++++-----
 .../util/scripting-engines/trace-event-python.c  |  9 ++++++---
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.44.0

