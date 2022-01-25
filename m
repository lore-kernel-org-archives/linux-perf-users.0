Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA48C43217
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 Jan 2022 02:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3410241AbiAYCSl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:18:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22416 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S3415260AbiAYA7l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Jan 2022 19:59:41 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20P0RFPW032189
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jan 2022 16:59:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=/wuHF6PKXyzwMthEJFK2kCrksFCsztPULufavb8uNNw=;
 b=i//WOYYGcydq9DaAHxaIIPf+rIgSBD+OIYTjMn/z1R953K1WWXYQrwBYR9yhMZXajmpb
 EkZesj93JhtgqhMEOxVWeiIqrRxdPrks8Mmyglz5tMSzFWjeqT8dPWUfmFE0jfEnx/zn
 IVVoYZD7x19UfgiFpuEISARPGjAYGlADXkQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dswd8me5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jan 2022 16:59:40 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 16:59:39 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 6D65022A478E; Mon, 24 Jan 2022 16:59:30 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <arnaldo.melo@gmail.com>,
        <christyc.y.lee@gmail.com>
CC:     <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <kernel-team@fb.com>, Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next 0/2] deprecate bpf_object__open_buffer() API
Date:   Mon, 24 Jan 2022 16:59:21 -0800
Message-ID: <20220125005923.418339-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LseM9kboCwZBve8hhRAp0e7THnK-0eUq
X-Proofpoint-ORIG-GUID: LseM9kboCwZBve8hhRAp0e7THnK-0eUq
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_10,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=738 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Deprecate bpf_object__open_buffer() API, replace all usage
with bpf_object__open_mem().

  [0] closes: https://github.com/libbpf/libbpf/issues/287

Christy Lee (2):
  libbpf: mark bpf_object__open_buffer() API deprecated
  perf: stop using bpf_object__open_buffer() API

 tools/lib/bpf/libbpf.h       |  1 +
 tools/perf/tests/llvm.c      |  2 +-
 tools/perf/util/bpf-event.c  | 10 ++++++++++
 tools/perf/util/bpf-loader.c | 10 ++++++++--
 4 files changed, 20 insertions(+), 3 deletions(-)

--=20
2.30.2

