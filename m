Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F59C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jan 2022 23:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245242AbiAEXBP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 18:01:15 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49422 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245232AbiAEXBN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jan 2022 18:01:13 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 205L2aCW023687
        for <linux-perf-users@vger.kernel.org>; Wed, 5 Jan 2022 15:01:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=2TC5eeBaMTo2WtQhZ3Ayp1PI6+oX/dxFjI9JY4ydg38=;
 b=AAajtM7MnsF5Pqtv5EsE9V/dSKFH93tqJZmLwyIPKeDkbQI+xAAtAnFRHn3wtsfqh8JL
 YonIqli45rcoBedfAd9PcG8IHAmSingAPxPRyELxyoFk+mbvboCwEBrfJlab92WXTseH
 bo1A+zzKg0RkwBZc/XU6p1+dmBY07JEj3WQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dcxpr77r6-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Jan 2022 15:01:12 -0800
Received: from twshared10140.39.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 15:01:10 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id A91531506002; Wed,  5 Jan 2022 15:01:03 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-perf-users@vger.kernel.org>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next 0/5] libbpf 1.0: deprecate bpf_map__def() API
Date:   Wed, 5 Jan 2022 15:00:52 -0800
Message-ID: <20220105230057.853163-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: M5apv_rIH78WePPk9rIgs1lmBY3Q5Crf
X-Proofpoint-GUID: M5apv_rIH78WePPk9rIgs1lmBY3Q5Crf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_08,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

bpf_map__def() is rarely used and non-extensible. bpf_map_def fields
can be accessed with appropriate map getters and setters instead.
Deprecate bpf_map__def() API and replace use cases with getters and sette=
rs.

Christy Lee (5):
  samples/bpf: stop using bpf_map__def() API
  bpftool: stop using bpf_map__def() API
  perf: stop using bpf_map__def() API
  selftests/bpf: stop using bpf_map__def() API
  libbpf: deprecate bpf_map__def() API

 samples/bpf/xdp_rxq_info_user.c               | 10 ++--
 tools/bpf/bpftool/gen.c                       | 12 ++--
 tools/bpf/bpftool/struct_ops.c                |  4 +-
 tools/lib/bpf/libbpf.h                        |  3 +-
 tools/perf/util/bpf-loader.c                  | 58 ++++++++-----------
 tools/perf/util/bpf_map.c                     | 28 ++++-----
 .../selftests/bpf/prog_tests/flow_dissector.c |  2 +-
 .../selftests/bpf/prog_tests/global_data.c    |  2 +-
 .../bpf/prog_tests/global_data_init.c         |  2 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c | 12 ++--
 .../selftests/bpf/prog_tests/tailcalls.c      | 36 ++++++------
 11 files changed, 79 insertions(+), 90 deletions(-)

--
2.30.2
