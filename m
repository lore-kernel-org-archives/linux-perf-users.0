Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022129.outbound.protection.outlook.com [52.101.96.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38034348C54;
	Sat, 17 Oct 2026 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792245412; cv=fail; b=qrFVcuihr6YoQP3G5l4Yn64hyXMaZ2Bg2dmJpkkRp1KROu6WvNRtt/ilmJKw2ZS9Zm5x8o84iimgyowpA5pTgI/XwHWgtmweZhG3tthrL21aOhT19BuX5Tcw/B0VPjb8oWD5W4qsv6vgl/W7Wcwpm4bFfQuGf5nPceSwLEVgZMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792245412; c=relaxed/simple;
	bh=9LDomrDFyZlhGrj2Q37IQQ1ehQXk6OQpDYSr3HoCGc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YY9tgXiUc1puRYDzNTupdMI+I1K9ecRJf6ygnC7kGShTSNtmjTnYSZ4yYzeGaLyH1rr2PRDMd6/RnpM76l7WTXRyMealX/cRHD1affB42NM5R0J/pdj6l57HAEKG2R3YjSacE0/xtmpjQ1LxWU+QbHfsSqBfLqZiJrLFGSyZFJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cK7MSfRLkML4p6sfbluHDl5rM+fzaFnzIRtziDpEmCuQrS6ameVuR+1/BYboRJCL0siZOFI1g7d8ROLxt4ZvbMTBbdJjNKqYVd/KVQfFHsL8sGS2VPmg4GHHF/Vo0SPYblTIc5k0LBTdfY5mfNDhjI0B4/Qpqs6jhm2t1c10nE3wXYzSlfnr2GHA62cEPQMtiVmtPuLWqgLaD+prOOipTws1rWX9WifDm4ZuqrXQV9GrYqbWZjkFVSMEhYVQN3gnx6ynQ3nX/q2oxufNek8gw1oKQ41CYfKxFUl5H+Ud45Qw0SMPMrvJWn179zdglN1gBltC8emwq9AYnzkir1PfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=9efrS2GlkIWeg8Bbdl/nQ5JZsjU1DuwW1ROv0gSpktc=;
 b=XKJKukeUUgvXSMuSb52OEqYDv/Mufw3qs7mp/gPAB1pqE27wjO5mnB6E0aya+/fJEoGUp+0nQTYaRWC6nlSCLUF0GwAN81u8mBD8xMbVCNAetB0g4Wim3KpJcAC0/z/+6Zpj59UK78jR9xulR6TNXJVTgGNN5PkuVqUE80vB/HZyqWxxU0GnyYJa8HMG2k12UTnrVKdLn/NOXS+YObw5usl9ACgz7xS9mfHKTQTKppjF/7vFqKx0ZvrBsurc8ZcRBLh3Pb6yh5CyHJUA4bwKJz4qqDoc2WglF4w/hNFuv4oCNXZ5lCMY1jjFRI+pJIB4esBVxXDbTbIZ9xvxlfHSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6172.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:261::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 17 Oct
 2026 13:56:47 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Sat, 17 Oct 2026
 13:56:47 +0000
Date: Sat, 17 Oct 2026 09:56:43 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v6 3/5] perf ftrace: Support display of
 inlined functions in function graph tracer
Message-ID: <2wkqzx2iiu5p4ghu6m6mtnlkoyzqwunasn27dj74p7aumi6u7g@xgxdayjv66sc>
References: <20261016040310.482876-1-atomlin@atomlin.com>
 <20261016040310.482876-4-atomlin@atomlin.com>
 <CAP-5=fVcd0KRWFtfTj2BS=A7m-V_EsxmDRGca41qiT7H1B8zgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP-5=fVcd0KRWFtfTj2BS=A7m-V_EsxmDRGca41qiT7H1B8zgw@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0990.namprd03.prod.outlook.com
 (2603:10b6:408:109::35) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 73320f40-2184-4408-91ff-08df2c567c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/kK80PqPJzapbUtfSir8CdOjKcrsOJYKA7GhfpO9E2dAyaqRD1wCSXJVxrIekIYKIsBIpTqgpp9T2xLkZ4DxzAknSQ4FwRTw8qDIU6kKn6pucab8qKrnzbjjxqqZtZvAOYl6kZLTQkdR+5TG/sbr5j75cGvxnuv+pjmL6qJRXhoIEvB0xtjqPOq/3hU8e/yTQL7CmN+2hRV8L/gTZ2PhyHXfJpJCAwKcH9HB4Ta+nMYXrq0XSaKdqLyd1Wb1FHFY3iHDfta6ZBTDD7T81CRdLevtNSHT6jgZWr2L47izdRXAN5C/+8Lxt6dEpsKWJ30xPfdrcyHYKyG1p70Y7ED9gmk7KQU3UW3H5VE6/v1tqqxfWgGiedTrho1g7YJk9Z+I9a2ZfLxo8Pr9iSw8/XDnvV/35vjmaDX8Wc1MLwhq2JxXRK1GcEtDVI+ERdv9Y8U2FL51Qu9K1WNxb4km9+btmEPONyr7CAPiTKLwnzaoELXX0IKfZmARhBVglx31u6oyyjpdbHzPRT/+zHy1+eS0r0kUWWYCLYjP7rMXD2l8r/pV96Ei9nDwkYUw4obgd+I5+XqkAWUtwWHRecOtq4L3qSehFTTcdZuCMAWcHUa3XAXB/j+xbopC6NBQY8yAog4iV9y+J4OPoVE1PKZWuINEYFEpYtfukVEexy3FAzBzNX8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk9uekJGQlR4ZkxkL3RhTW9TWUFuLy9KajdTWkFxelNjdDFhd3dUeWEyQUhw?=
 =?utf-8?B?NDBFSm51U1o0TGdKb1orY1VrUjhkWnlLemNlbjVJcmRvMWZRSVNKZUhKUHR4?=
 =?utf-8?B?ZGE5ODZyZTFaUjltcjR4L3FJYmNXMVI1RGs0dFZYbnZVWlRWbW8raS80akY1?=
 =?utf-8?B?eHZZa3REbHR3WFZxT1ZTUEZlN3pFeHYwTFEzczhhWGZuY0FUV3p1czBtSDhu?=
 =?utf-8?B?ZnBVbG5FaVVhOGZ5U2FEMTR6MVpFV3p5bWV3MWlrRDhIVlA1NkpGejdHRXhj?=
 =?utf-8?B?Zy84QTVvTWhqbUhvYzBGYjRZSzJHYUh5UG1FQnVQU2UyczV6UmFxdWRRbHZs?=
 =?utf-8?B?STF2MjBGSmd5cm4vTVdaQ0FHLzY4VkVsMGRHWnE4KytBa1hlVEJadmlNbXlG?=
 =?utf-8?B?UEhUNFMvRzBXdWN0bDU3N2xQa0JxenVkSXB6T2Rva3lreTBEcG9oVnRZYVI1?=
 =?utf-8?B?U3VvVVlQVytYaUduVWJKZXBpMDdjMTl0bTNJWWJkc3pPeWdmSXNvR1VjQ3dI?=
 =?utf-8?B?RmpTNnN3ODlpdjJmMXErNUtVRGdFZ0loYnY2djM3NlRCeThsMEQ3b291eFNm?=
 =?utf-8?B?Ry8rMzBydlR5S2NWOTZVU3Q0ajF1OGMrQ0p3OVA4SUZJbFRCWUJVQk1yNytz?=
 =?utf-8?B?Wmh1dGtjNU9YVUtCOUdTUy9XTjFHZGd3TURmWEdnelRjWXU1RWtmazhzTUh2?=
 =?utf-8?B?d3pudTd4MHNQaGVjRHFHYjlrcDc0TzJZOGhxaGQ1ekhHTnRQbkJXNW5BNlJ5?=
 =?utf-8?B?bUhzV1RWTndEelVRVU9Ddm4wUFhFOE9lMlJUMmMwTERqRHJKak9WdkppeVFm?=
 =?utf-8?B?d2lWL3MwdGp2RGl1aDQ1REdCazJKekNPTm03UDgvaUNrdFgxSG5nVjNPaWdT?=
 =?utf-8?B?eCtERXZvNVo3djRjdHdKZ1BYVjY3OWgvRkJIWEE1NWVTblNtdWFpWjBoTksw?=
 =?utf-8?B?SThsck9nbDVjWGVRL0piNHZ0bVpPYU05ek9qaWJsUGhIU1NqTFZncTFtYTdl?=
 =?utf-8?B?akxESHNmanpVV0RvbE1OZkc3NXZSUmJGOVo5a2xyenhBUFNxQU5XTGFUSXlX?=
 =?utf-8?B?eFVvSjZXdmtIb3hTL1hzVFRJTDdlUGtyQ2tHTktxOWFTZ1RkQkV3QTRzS0Na?=
 =?utf-8?B?LzhvWjNXNERXOWVqYkFNZFVuL1E4UDlhQjJVeWN3Zm41bWxHTFQyUEtTQlUx?=
 =?utf-8?B?bGE3djlteFpzT0k5b00zVXBlL0k3czRHSStUN2RtdVVUK0pwNXRmcDgrcnFa?=
 =?utf-8?B?NENrNjR4SVl3TTE0QjBkemRXR3JRSkVFbXhQajNKY0ZhRXpHSHo2V1BBOTRD?=
 =?utf-8?B?ZGdlM3QrMWU3ZWxwMWZqcGZaYUIzRmJQTmxtSStPWU5ENFlSY0cyQ0tidWwv?=
 =?utf-8?B?Rkxid2VaRFQvNTM5aVhTNXB6KytlYXhpRllNc1dUWVlqcTVjZWlzVjI1YnZH?=
 =?utf-8?B?enhLcXZiQkE5akh2SWlQdkdMV2lDY0JXNzl5aVUzL1o3MnJEdFZlV2pINWRw?=
 =?utf-8?B?Zk8rclNuQkYwNi8vWGM4dXlFeDQ0cEtVVWtVQ3czY0ZqSUZkSnpPOEFZZ0dN?=
 =?utf-8?B?bUlDTnpvU1JjbGtUZFZNaHJ4N0hQeW1vdGhvc1hDc2V1b2JxTHd0OEVTV25O?=
 =?utf-8?B?QlJFM2lKNU1OOUZObHVQeVNKY3lJVEo3TXkzOHREY212TGRyWDJWUVMvaVEw?=
 =?utf-8?B?U2R2ay9QV2tNZ1ljWUQrazdsVlFtMm0rU3VqSFk0cWdOT2E3NWgxbm5TRklG?=
 =?utf-8?B?U3BGUHBLcjlqVyt0OENnT3M4cXpVcjdlRklHeEplOWZQeEtpM1BpNUF4UU1M?=
 =?utf-8?B?KzlYQ29uY1dhSGsxOTd3TElXWksrUG4yVEs4aWVTOE5nVEZFL3huaTVRV3pL?=
 =?utf-8?B?bVdDOGtDZzJVYUZQQWlTMDl6RlV4eXcrbnhTRzEwb2ZoQXliQnE4ZU5KTEVE?=
 =?utf-8?B?S0NsMTIwU0tUcVlhd21MdTZGbHFhaFk0RFJUVUhKUWM1d25XSnJwOE1MMktP?=
 =?utf-8?B?czNUZEdOb3ZYTEpESWY4SXA3a2JZNkRJeFVVdStjWmRiYmpXTjk3Q0NZM1Vy?=
 =?utf-8?B?THU2bUs0cVNheG82VCtGeWQ2U2RGK1VadSs1ZXhaOWFrdkxMTitqQ0wrS1Ur?=
 =?utf-8?B?VmRhRzNSK2F3aXBuNTBNSFFVNE4rRkVuYzQ1U1EraUVSTGlRaDFEYmRQdllX?=
 =?utf-8?B?aldBc1g1Sk9SNWE5ODZtK1JIMjEwVm1GQjQ4QWpOUzZSbGhhY2ZiUUpVdk9z?=
 =?utf-8?B?REdnbW5tczBVTkYvV3d6Lytyc2JhMDhMYnYwaDZPTkJSNTk5OS81Q3lkdFIv?=
 =?utf-8?B?YlNXa0VVQlNCLzU4RytTbXZXYWdBTlB0ZFI4YXR6ZHBoVis4eGJiQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73320f40-2184-4408-91ff-08df2c567c44
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 13:56:47.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWfTe4cDjm+oENroqxXMRbmFqr/msY8r7FtnJApfjiSDrDvgCOoOD1I3NYpNbGfTvWqTCYnuLQd6ysyKzz47wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6172

On Fri, Oct 16, 2026 at 09:34:07AM -0700, Ian Rogers wrote:
> > diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
> > index 596cecee844e..ece7f4b73f44 100644
> > --- a/tools/perf/tests/ftrace.c
> > +++ b/tools/perf/tests/ftrace.c
> > @@ -7,6 +7,10 @@
> >  #include <unistd.h>
> >  #include "tests.h"
> >  #include "debug.h"
> > +#include "dso.h"
> > +#include "machine.h"
> > +#include "map.h"
> > +#include "symbol.h"
> >  #include "util/ftrace.h"
> >
> >  static int test_parse_retaddr(void)
> > @@ -62,6 +66,372 @@ static int test_filter_retaddr(void)
> >         return TEST_OK;
> >  }
> >
> > +#define TEST_CHECK(text, cond)                                 \
> > +do {                                                           \
> > +       if (!(cond)) {                                          \
> > +               pr_debug("FAILED %s:%d %s\n", __FILE__, __LINE__, text); \
> > +               ret = TEST_FAIL;                                \
> > +               goto out_cleanup;                               \
> > +       }                                                       \
> > +} while (0)
> > +
> > +static int test_inline_processing(void)
> > +{
> > +       static const char line_entry[] = " 0)               |  wake_up_new_task() {";
> > +       static const char line_enqueue[] =
> > +               " 0)               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */";
> > +       static const char line_exit_enqueue[] = " 0) + 10.000 us   |    } /* enqueue_task */";
> > +       static const char line_exit_task[] = " 0) + 20.000 us   |  } /* wake_up_new_task */";
> > +       static const char line_bare_enqueue[] = " 0) + 10.000 us   |    }";
> > +       static const char line_bare_task[] = " 0) + 20.000 us   |  }";
> > +       static const char line_unmatched[] = " 0) +  5.000 us   |    } /* unrelated_func */";
> > +       static const char line_verbose_entry[] =
> > +               " 1234.567890 |   0)   bash-1234    |               |  wake_up_new_task() {";
> > +       static const char line_verbose_enqueue[] =
> > +               " 1234.567890 |   0)   bash-1234    |               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */";
> > +       static const char line_verbose_exit_enqueue[] =
> > +               " 1234.567890 |   0)   bash-1234    |   1.234 us    |    } /* enqueue_task */";
> > +       static const char line_verbose_exit_task[] =
> > +               " 1234.567890 |   0)   bash-1234    |   2.567 us    |  } /* wake_up_new_task */";
> > +       static const char line_verbose_inline_entry[] =
> > +               " 1234.567890 |   0)   bash-1234    |               |    activate_task() { /* (inline) */";
> > +       static const char line_verbose_inline_exit[] =
> > +               " 1234.567890 |   0)   bash-1234    |               |    } /* activate_task (inline) */";
> > +       struct perf_ftrace ftrace;
> > +       char *out_buf = NULL;
> > +       size_t out_len = 0;
> > +       FILE *out;
> > +       const char *unmatched_pos;
> > +       const char *inline_exit_pos;
> > +       int ret = TEST_OK;
> > +
> > +       memset(&ftrace, 0, sizeof(ftrace));
> > +       ftrace.use_inline = true;
> > +       ftrace.filter_retaddr = 1; /* Default when --graph-opts retaddr is not specified */
> > +       ftrace.tracer = "function_graph";
> > +
> > +       /* If vmlinux is present, test resolving symbols */
> > +       if (access("vmlinux", R_OK) == 0) {
> 
> This series is great and I'm spotting nits. Could we try other vmlinux
> paths here similar to the symbol code? It also seems an early return
> could avoid indentation.

Hi Ian,

Thank you for your feedback.

I see. Looking at tools/perf/util/symbol.c, we can indeed utilise
vmlinux_paths[] as per vmlinux_path__init().

    static const char * const vmlinux_paths[] = {
        "vmlinux",
        "/boot/vmlinux"
    };

Acknowledged. I will make these changes.

Kind regards,
-- 
Aaron Tomlin
