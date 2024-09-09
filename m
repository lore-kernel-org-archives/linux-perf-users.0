Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2124.outbound.protection.outlook.com [40.107.94.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EE518A943
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725917429; cv=fail; b=NJxJa47yKOZTSP0c/FUcN02/LfsP+BB5MKhB9NFMP4m9XFf4AiHL1shBaepq3FBVU8GU9bq5Jx+iQpOdO7NdV7Fh/062xHlQ/M6eTvIaCc9ZkpNWu7FO7lezlyihbE00TEG2+AOuEKyAfZDhUw8H7upwr+6KSX8aC1cjK1EQ6J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725917429; c=relaxed/simple;
	bh=bjyMrLfJVcCQ2N52dm1qGiYaxkawym1M+R43eO4Z6os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BknWxrHws0AvU/d5jcyVYiRO+wu4OjGVzbPy6xNfwOVNB+nhQmzn8CPtF8D1GeWDx/0q+hvXbwYcb1u2LdovmQOG+gOqYPJTEF2zhjrZ3Gk6i4zFibHex8OPb0xW7VFUdXdyTs+bb7e4E8seB6ExojogQadujLXEVPud33++6rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=HfrXmyNU; arc=fail smtp.client-ip=40.107.94.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="HfrXmyNU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udKicyBekrh/G5a21ChY/lUIWUKhhosBcIU59XikWKYtxC/Uz6J4Z/u6tORETgBm98ArNEK0Rh8ryelay7EDd7hQ6CPbXT4WHmHhNsvP4x8PUnwimJBd9UNwSM8iCdoygq5kLt6SFQ2ICG5mHKQ4OUDMIKGX/ynwrkv9/zimmGQehOyK2sZ0topXKNp1tK51Y+ZHTn10Td8RdwEuj2TabtkSBh8IbMNy6IVBcWq0jwC6vX/xfnCRCyr1G9N4AhI1cHoMA08yAOc/2ejR0N+Ff7VHl4VmSiBXWPLuXd2AbNQ/IphpQ8n1OMI9sp4QCgvZm/qQhz21HcF55Ha1F00OPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZxRyQX91aCNe2kRtYdGf4y7mmJPYNbti5BlN8s6eN4=;
 b=NVbvaEnh8i0HUj85j123PWI/bFQCNFymOy6sbWIvcInteQlYX/CAkYBKqDeKZ4SMqU7qYWHKZ4+/fIsns3Pt9MIN3ycSNkNpQxRxNbF/7PAUYK1pQ1MKUIgdkd8Aj7q7iWx451NlVe2e6cgY97LwbVzpeqm0C1UYGF2LdJCrV6thfLi+1DTtbFI1k252S/P0MSeVsiMRUrsv00bdSSCkS1fAZXghSKrbKkUBvkdHGNJbbv44jOTGqgZzuuqcHubCuvcIqE2hoynehBCKA/MkewfoRh9zVqUWi+00/TOmLV6YeKTP0JqFqB70FnOzqOY0dxmtiN951gkAdf1VZ4hVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZxRyQX91aCNe2kRtYdGf4y7mmJPYNbti5BlN8s6eN4=;
 b=HfrXmyNUZ2BK6L1SYgDNkwRs2XeKJ4XZ/tE699l3MoZdXqbKFXJTaoM65awFjr40J5TDDM8SvOXR/lwCURWOR2k8HfbFuzWr49nh1k9PGrv1+M90aDJFbCwGgIWcD6SsH6sBVfzBOa0yKTwb24x93vFFJ/27+8YugWieHK61kQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 DM4PR01MB7618.prod.exchangelabs.com (2603:10b6:8:61::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Mon, 9 Sep 2024 21:30:24 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 21:30:24 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V8 0/4] arm-cs-trace-disasm.py/perf must accommodate non-zero DSO text offset
Date: Mon,  9 Sep 2024 15:30:02 -0600
Message-Id: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
References: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::20) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|DM4PR01MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7cbe7d-2ae5-4264-ddf4-08dcd1169d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DVc0+etKFVdcysgOh1yX2dMMDdwBA3Omq50upfCPqiZc0DYkX6Iv7IEm4nJu?=
 =?us-ascii?Q?ZsHN7j6X6niaKwjjnVYYYXkAGo8Lkd1FHSmcu4fmDMPg/yob2tCHQZHEYvA0?=
 =?us-ascii?Q?9lBNQ1AaQ/03BzTdTxo96g6eqQunBg9EZ+9LYEdV0ZoWOYi0/hTPSTN3lOp1?=
 =?us-ascii?Q?fSKrI9Gsfd6qIUFgawBJXJ0tmEVj9VO3UvUGgVuiWxKnUpw55C1aNPQrFUE7?=
 =?us-ascii?Q?WpStaqGhNNyQ71ILCWxmUvd1Z/SA11RaZBAAIF5l+7DjHayEnDTf8rEc8KVP?=
 =?us-ascii?Q?k6+C4884nCbc52D11WO041JxO24EOFbGQwkmpkM+evBpW0/HfDODV3uSc8bo?=
 =?us-ascii?Q?nEl6vYj0hFsjfvndprKUEsVIWzDhKCZMSste/gNt85ENgNrkhHKe2YeKj9bW?=
 =?us-ascii?Q?xvQRybEeBwDTMjD4FgEHP7jAHdCsggcz9S1zSYGdl1gQcQn2ahR+lSbd25Av?=
 =?us-ascii?Q?TGzvBIYiXruB54YDX3Sk13ioZeBPX4GA7s+TV1tNgY+hf3opI2Tj5iKBLMYc?=
 =?us-ascii?Q?y20ei/TVOzdfPWlCF6Mv0bmN93NYL2D3L68CqfbyWM735+tuxLr7X1Qz+ZKq?=
 =?us-ascii?Q?z2V1SdDHcv2W47oBErIRdq1D66ZJAGV6kBlKYpBm3iOBAK6jRO0lJTrL+GXD?=
 =?us-ascii?Q?8UhEY5W3JhWjwkMpYQ35WHu14B/JCnd0zk0H+tKzfxwbxIU3KYwNKJOguB/N?=
 =?us-ascii?Q?uxkls3YW3kZL7cTFZSz8lOPY3/ziLpei45DkXHY3FyoKplJJZxQAzbIm3s4Y?=
 =?us-ascii?Q?VnfNodtUr1rzrrtCyJ9d7SvlODTqKvBhQl6I1Sp0cdRW1NL3DbBUaTpRpw35?=
 =?us-ascii?Q?H7yIpOxX2fJz4Y0uAgytlBf9j9COaWOWMeRJ5fl/NN0HojXmlVFpw546tGZY?=
 =?us-ascii?Q?nfSJovNeyt3QUkzWRZpeDcKgDdBx4D4ap6EEBSjN/bsBkKpgBu02aZcViI6V?=
 =?us-ascii?Q?YOEmOPWXbL/7SiZ73+LY879RJQkktBjAj5p64Yu/fGSv9j38sXgPVIi+lTo7?=
 =?us-ascii?Q?k7lR2VyrTXfDrfCtxSO4UmEYyyZ96zKfeBsF0K+52Kmg/0p9e6fek8Sl+Iza?=
 =?us-ascii?Q?NJmIVZt4yAJmTyWwYsgiSMGnVZeRZkpMTSwtTGJ6j7qLgYbTrwq0ht9zaaoE?=
 =?us-ascii?Q?BcZ+WbJGY6Qj3bqogsZeo8pYQUZgfPmHv0DSHK13GGGiujrbGW9179e/DNyX?=
 =?us-ascii?Q?4UH/5Ws2w8SrwXL409+P7GnJPV4ywXj7CVh+39GZHatKPqUXihL5rlncJF7/?=
 =?us-ascii?Q?metglffmXSGP0certBfCGaQRWVMwrlwWs69vf6Asg3C6/LPSmBh8+zrTjvNM?=
 =?us-ascii?Q?ljhYoJWCr7ZkDGG+1Pbiixk1TQWffn6RIW9rN63Pw9K4qfoNHR5/IxMgqgb0?=
 =?us-ascii?Q?tHEZGig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Opz4Ney8//TuW8Y0gHYYEm8YihxmeI7mI5DTtXmh8Ylnz8a81xqBdDCIJL89?=
 =?us-ascii?Q?vl+9CSf+b758uFwQiI8GTNGyQ/dXKqb3kfUwvDBrP7rT1tWlRDzxujxRhepJ?=
 =?us-ascii?Q?JfQWDIxVzGSA62wVVWg05T8ZUF7r+OOaBnmAFMxyDFeCThZiSQ2o24zqvbUX?=
 =?us-ascii?Q?FdTXkoskELYGKm9j/WdTdigHabEmNVemPEUDKEAvR9bFfNIaFp4cuXX5vIP7?=
 =?us-ascii?Q?PYq14Vg5GmEzoxOiaRYE1zbYOOkE5ABOEGj9AzHEfIq0xfFHQuh/+Lr8Nw/e?=
 =?us-ascii?Q?7vWlBMDEpoWNFazXXm5VwnLp2dLJR2SXLWWUfN7+6Xa2i1EHShSuSXfiWGha?=
 =?us-ascii?Q?rSRCyR3iBxIw1SDLdGuBaW29IFjaQAh5uVYa5ApC9m+Ih0uhd7TEhIn1c0i0?=
 =?us-ascii?Q?CmeCwHpNzFhc7eHh2nWkhkQlbVXrnDngL/c5lcQV+AMo/5Ln+HfKfQSBJB6x?=
 =?us-ascii?Q?F1MrskQoePG83hvX9D/+wtzt7aWa6mHxMzg3b9bEf5F7o3yqn7anfK0hMHNm?=
 =?us-ascii?Q?nX7203i0ngt8xbQrEgNwEKuje41mh0ifoLaiLUWmdzr/ZGHGwp5zJdxeX4MA?=
 =?us-ascii?Q?N74j8ECscEwY8XntG3IP3MJ8Alet1o3cJ3A21k5B4VqTaLe/HlHV2n/D3Mjy?=
 =?us-ascii?Q?XhQCejPOpQvDfnm0LFR0t+LWdV3+zxD4yXFlDbRrBTsNvYBwI5f+ecWEKTxL?=
 =?us-ascii?Q?phe8UGdOYaEq8zkPQrcKtJvnyMfLSEA2KVXYgqkEJuODJcd8QcwtG1qshyEr?=
 =?us-ascii?Q?A3o19KOzvZki4Goa0mIeX5ROZIdlKBOls0G3mV0OtK54/gdTknv5V8sdn26U?=
 =?us-ascii?Q?DDym5qxfzEhTz3qjT+wJ+lzGoYW29ycF/6CzeSEXIiIHCMlyMuV6iPhnmtNT?=
 =?us-ascii?Q?bsFioocMD5S9nSJaywx4iHn0jbewNpdM7zm0CWm7k6nQdCWISlka3GM64MbI?=
 =?us-ascii?Q?NGtZK6g8S9+iLKuU/aAHq6GBPHRPuWkwgSyU+UP92qagcttB4ZQcTTuMCsii?=
 =?us-ascii?Q?nq9lt8ldIJq+mBpM8vpZcez9x9wboejLMrUEUhRgHXzrICTM+m5qoFEgq7TU?=
 =?us-ascii?Q?IYE1x50kmBpwxe6mU2Cfv90VUrUcLDYnXZV5LtVLkepBtweCcGX7ghnSAjgc?=
 =?us-ascii?Q?iowTavCnUlDYzyt8zerymif9X8+i8jDcm7tHMxtqLFSTNCLj5aM3z+wtlscw?=
 =?us-ascii?Q?pBOEEkYsn5Bqghu41oY6LoVwPboSiAJK+dQtgLdEc2Q0vWlYNImltvqUySSe?=
 =?us-ascii?Q?qh+tZ2vSfmp4eYQ4hjXhQqR087BA68GWOHvO+Bh0efhWQDsBqyuk4wPCZoW3?=
 =?us-ascii?Q?02OS+WpDRh71pcpWJPw2wr8X8U/kNU/Q3NNxcJW0mg0yjCHPmIJQznsH6Vpj?=
 =?us-ascii?Q?+Ob6er9omSS2Twd1uMFoByyxbvFI3IoXnFpwwa/MskqE2frScECMHurGNq+7?=
 =?us-ascii?Q?160MhS3Sm+UzV79rboqtcyvaButYz3EP8wkVDInTx864UDK6Nt6ed+a3yTbx?=
 =?us-ascii?Q?yl7WG58z25uFdY7Z5oqfaa3z/n5B8DhwXPN94iIc9zupWDcM1nWYuPo+JQXz?=
 =?us-ascii?Q?LttFK9uVThZj5Wfo7N2BoD5ZroD8g3AkDvLWiZmQzJ8LHqW4qN9BY07PbBm0?=
 =?us-ascii?Q?BKerxynukfKAky287NuaAb2dDZC6kT/9BEW8NoKN3Tb4?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7cbe7d-2ae5-4264-ddf4-08dcd1169d7d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 21:30:24.2599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMrww3n9gfOWzLNJY7p9jU3lyW9hSH+N2X8W+8ZdgdwzbFWnym60FgY8ktqZCVKBg5Stq3XjERiOlIAY65kMrhK8IqH1oK/Nw311WrFO9FgUFsxOnrhZT5ZGk6BEPswY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7618

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

Steve Clevenger (4):
  Add dso__is_pie call to identify ELF PIE
  Force MAPPING_TYPE__IDENTIY for PIE
  Add map pgoff to python dictionary based on MAPPING_TYPE
  Adjust objdump start/end range per map pgoff parameter

 .../scripts/python/arm-cs-trace-disasm.py     | 17 ++++--
 tools/perf/util/map.c                         |  4 +-
 .../scripting-engines/trace-event-python.c    | 13 +++-
 tools/perf/util/symbol-elf.c                  | 61 +++++++++++++++++++
 tools/perf/util/symbol.h                      |  1 +
 5 files changed, 86 insertions(+), 10 deletions(-)

-- 
2.44.0

