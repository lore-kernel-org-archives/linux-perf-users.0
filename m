Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BF5C7EE25
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jun 2023 07:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjFLHto (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 03:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbjFLHtP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 03:49:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EE61710
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686556130; x=1718092130;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D86qkQvt2UNWichTVqNgBXInDZW0aMfuRCZr9V4InUM=;
  b=OpXnr4rAEjnXPDjip3hnHE7bvJaHOfccyf4B0grIlxrNdE/ftK86jS7Y
   Jz0sZbo5Pl+xGNj2iz7tvjpcY8Hc2dtVkRW4qGSNUXMVKwsTiJekfLXq5
   kcj+muJXTscIclm7RxeZQGn/QPRHl9BbYraYcqBXEOZ/eSz9GbW+ZYa0Q
   BT/CV03ymhKZg7p3adgYnuIkeQ4oaPtGn0CQ2ehhs9I/Vg+3lTPfGlNYw
   8GYFmZKAnR1lxTrFRWqcSN6CnnKZnd5KbfV+8ZhTS0Iu0hgZtAgRV3rmB
   KtCcyeHJ3tDj26NG96H5pjE5GDFYG/fzTTeALOdUWbbXf+NqHw3EgRcdX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="338323126"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="338323126"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 23:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="711087351"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="711087351"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 11 Jun 2023 23:40:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 11 Jun 2023 23:40:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 11 Jun 2023 23:40:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 11 Jun 2023 23:40:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 11 Jun 2023 23:40:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5kJHIIrHw8vTK8BE8mW2DS+7ELiTSnj2rRAhtiCYUmgW/4xIzxdFELKohVpt1206ktoe7I1Z8qXxAMf55G+H8FoBFnUi/gZ2XJbDiWYFMmIeh8cYr5I1Egkur7KRLRDIj35dPkh1U5MPlFyFTQxQ00JqEpfcL+oVpdhKlomFqrpQh9y4MIiyhXDgvpo2EPMd29+1iqJNyMgbFXyjDtslRs+tN8CYZKmuIpVUApnvbC9RxtyKBfakavT9T2/sll55xutjka/394NkFwRTeOKJ1WbdByHd/CgxpOVj7k2WLR1jdxM3Z0h5pwbU6pMc9me+hYD54JrQw4KggqUq9U76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFi1nplrKNiGVyqrIBtyLgQbt1BhngRvHZnE1bo5k5M=;
 b=PWMkE4+4NxDe24uxHWy//QjAb8yj5d17dC0KQiPbadvgxxdUUYPw7Oz0hfBmJuLzlOb3ucqp8xP4L3kqZVvNIkWYl6tFHjJAnX4p1DP6pYumH6fhGcF9CHNOejHWObf6g2esaTtXJ+TTxOiJVUAsk6F9LawN5qjc6GwGkfg9mQ5HphpNtgu1XfvDuHjWlSfyaciQpAszwA5VkaBuVp0/sGjBV3T98rlumLMzRI4o4ZVePg+NIpLBDvFMP5gNkRYdlDdsfbM9VAm16m/rf/bybmNREDRWlbrD05S5W8Xul9uO0jAPiFChlqlun/TjNZWsmwF8XCj7j2IjPcwztqb+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MN0PR11MB6232.namprd11.prod.outlook.com (2603:10b6:208:3c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 06:40:12 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 06:40:12 +0000
Date:   Mon, 12 Jun 2023 14:37:04 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>,
        <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [acme:tmp.perf/core 89/117] tools/perf/util/pfm.c: util/cpumap.h is
 included more than once.
Message-ID: <202306110636.2sTsiAcl-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MN0PR11MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6aa1ad-7259-4382-7717-08db6b0fdfb3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikzNDtiFIRHNZvzAXjIW5yl66INwqEKC3a6Wl5fvAWxEQ9YnrpJ1GrCbVZybvvba3/5sAwmp1sdKWJpls0/7U4S4C2C20U9G9v2wfEuE6HG12LKaYUk9e+zU5MEmyhCam9DKvWtIikiRlSbcNF91927fOdHsRDSro7WD3Wn4j1eMUwIOa0TKyk/4I+DlSrDP0mOKT7bAxv1Nv9J425HiK2A2VcbfpPbRKCn3kfT6RBy3n6cK+jvSo71zEYFSFMSj+Kar3Sm1X8f6iqVu1mTaqiI7YAnOgJegC1i7ht3DzOXRRf7uZcpF3tIkMwpn6BxnZMEeOMshIZzu0bDEUZ0kI5mWk+ZtbfYDEhCcpPrL45CNjFgMiCsOC25Tly7VX06iqt1319LCrsSHjQ0u2irAtO+hoPBNCj0oUVew1hLgHfOQnvJkmeB76JFg5MtS34wmq2SftfRhP/51G6RCou+FWZX37d6XvVn/ru03yjp9OZ25cMWH8rUkCviTUh8hh+9MhxBk5hVE4kMeGoA9+hExAtN/0DvD029USTZB1aKr99k5xXvBdiQniLfIGmovFBnVoDr0UiWhRJuQv0tfeQob2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(84970400001)(316002)(41300700001)(36756003)(478600001)(66556008)(8676002)(82960400001)(66946007)(5660300002)(86362001)(66476007)(8936002)(38100700002)(6916009)(4326008)(6666004)(2616005)(2906002)(6486002)(966005)(83380400001)(186003)(1076003)(26005)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?546w7qxDmCjPpV2mx84h8lKp6iXJRImiJmPiyGhenSnaOBTEaCRKSJKzWr/h?=
 =?us-ascii?Q?O62uLZl8q2F5DQmhYOAB99363SQqX2vbK/Hze5rb9WqLqvASOpVEmOQKkGjr?=
 =?us-ascii?Q?MoVEGiSN4LHYY84DqMrREnPugWvYDcu0N+uu9zMtRflYksyN72/nJiD8UCVb?=
 =?us-ascii?Q?rDDnpLMCQS09Ox495Ghpr7O8qiYk/mixRxIN7B3GsEcZhqT3vGpEiKkUF2i+?=
 =?us-ascii?Q?vY+VrkCWFD0pa0wgk93SVie/xae4bcMUBztzpV4X+24Tgjwl//GGAO963wHY?=
 =?us-ascii?Q?th/C7PBb1MOyzvaPYU0pI/VbgHS3VKVDiWfwkoehcgg8YeimYX9X5MdCOyVF?=
 =?us-ascii?Q?2dHtYbvf6uFZUI4DnWbjjQXtzoGCqT8QEvczInlM7csjccPnsxVLXlTMMTp0?=
 =?us-ascii?Q?ECTlj24fRkSkoPxtE8ISWzvnok/u3P5xnGJzjbo7OqE/6ngdsvBv7tLSMJR+?=
 =?us-ascii?Q?qy8E+dWL1DI2/KamFWNT/geuB4ATIzBfA93R9NkRQ2VC3A2XSseo5mcbD/x2?=
 =?us-ascii?Q?XIFUFXNm+Pf6EBPS3lWBbdgacONI9iQH2q9S1yNv3xrFHxs2JpY5nXjTPiY9?=
 =?us-ascii?Q?vu3gv6EFkRJgYm1mD9Y8Ce/nUnuyqkH4eoeyRiQhl2zbcg6JGebDBGpk3B+S?=
 =?us-ascii?Q?UExsW0EocXS6qu5CFszCYdy+Pe7w9P+N/f5+jw7CfkTQQCaIyjZZlj2dGsHp?=
 =?us-ascii?Q?sVCNhjOaHr6OFAZI2qep6plbUNl8Ydb3rGVO5xFOYLRJhOfoWu3qd7o/8E8S?=
 =?us-ascii?Q?kvejal/N8LdK6z+94OAU70ou2k3ZWdMRCjhYiQSo78ldZjonjOnf5rVEzNiD?=
 =?us-ascii?Q?gIEdSXHmMPqaLCdBmbEnaqfYx2Ea+fbZREv0AsOnoMuxHUvl/aG2oqEP0sit?=
 =?us-ascii?Q?Ay5yDApwx2N66mJLrDM9GhKNoekQNA/yn6A+0egAZE6bfkf8nGvdeQcF7VzG?=
 =?us-ascii?Q?ZNWOwrq9924CjN82z95Z40LMsXmEdqVYil8eeB6X4f7dhoIqbtZHtaGYq3nR?=
 =?us-ascii?Q?IyhkghjdjOKk55Lc08q2+KO7rSTfkzZgx9poT6fVHczxZNVESQa6u8hm8Zeh?=
 =?us-ascii?Q?R/EQ5ID/plHbiXLrb2b/93tvCsddoQmCyNBe7wmvS/wnuNtM9CUGtXN9E2mi?=
 =?us-ascii?Q?qELEX0U+pZ1X2TFIDbjZlzVtsoAqEL1xPr/Y26QRFWlNACTuiTEToZp3peJo?=
 =?us-ascii?Q?Fb7BeJSmEBQc0XDw1A8ID3zxHTcN1F70pv47mkIPT4U1nMGiF7svG/c+MFf7?=
 =?us-ascii?Q?Ssk6D3U7nDtAIs6acRFXtukYO6aSxphVpsRjWMkEYvjNDht+prL0kpgOdsrc?=
 =?us-ascii?Q?qq3JQjGgyRcCPMOmMa0zezPN5KYJqlAIxg6cl8NyeHJXvFTfb7xrxFvEV7oE?=
 =?us-ascii?Q?Q0PKmhF1O3ah5f45JMPs1tidE+AIae2K0f1b6gkrLgbpDza1523gt9IRiVWL?=
 =?us-ascii?Q?jg8HJLyVk4cpW3HXxWM5NDy8jBrIdWkktukmvJI3HXVBYTvrLluu7AXR/bWv?=
 =?us-ascii?Q?P69c/SUUhDo/UVdsAyT4bdCUn8XMFvgY8HbYmYVu30ZP6V70C3UjzdtCu0TV?=
 =?us-ascii?Q?fkvVZl2P0GT5HlKE0TZ2uo4q9dpYVvZYUB+klqMB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6aa1ad-7259-4382-7717-08db6b0fdfb3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 06:40:12.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cj+kTgDZF6QJPKkpojTqxajgFg/bUBDiNHXdn04zXnbplGamDhDMt6FPUWyKg6435dVB2+V4xJBSyq3/8D/aig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6232
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf/core
head:   fa9f16805e705fbb243a74b60f803cb33f1ce787
commit: 975b6a641af18e471f9a8b764e26d202808cac16 [89/117] perf list: Check if libpfm4 event is supported
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202306110636.2sTsiAcl-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> tools/perf/util/pfm.c: util/cpumap.h is included more than once.

vim +7 tools/perf/util/pfm.c

   > 7	#include "util/cpumap.h"
     8	#include "util/debug.h"
     9	#include "util/event.h"
    10	#include "util/evlist.h"
    11	#include "util/evsel.h"
    12	#include "util/parse-events.h"
    13	#include "util/pmus.h"
    14	#include "util/pfm.h"
    15	#include "util/strbuf.h"
  > 16	#include "util/cpumap.h"
    17	#include "util/thread_map.h"
    18	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

