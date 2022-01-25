Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7CFC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 Jan 2022 02:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3410828AbiAYCSn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:18:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30268 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S3415265AbiAYA7t (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Jan 2022 19:59:49 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20P0RFDl006279
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jan 2022 16:59:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=PVEUvBqgjDTmVGIHjcmGjRxY9qT0P0GdiCgOCN08cqg=;
 b=R9yLBGCMBKVJ7otWmhsWqiIdmH9+8sjiXY0l8l3iiobDRTvQOxqCfKsOVxVg7tFuKb8B
 fS6d9JN1gdCEeusm+86Xdg5Emb92WTP6nvJ8MJO01m/HHRNMuV+zHql8xIoArKY20iic
 jEPFAMSpS1SvQfQDk3cH0PZsZqoiYhHw2D4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dssx9wjw7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jan 2022 16:59:49 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 16:59:39 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 3CF3B22A47A1; Mon, 24 Jan 2022 16:59:32 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <arnaldo.melo@gmail.com>,
        <christyc.y.lee@gmail.com>
CC:     <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <kernel-team@fb.com>, Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next 1/2] libbpf: mark bpf_object__open_buffer() API deprecated
Date:   Mon, 24 Jan 2022 16:59:22 -0800
Message-ID: <20220125005923.418339-2-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125005923.418339-1-christylee@fb.com>
References: <20220125005923.418339-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ep-UzSCT0Qt49CE5K8Zim3SdAByFit5j
X-Proofpoint-GUID: ep-UzSCT0Qt49CE5K8Zim3SdAByFit5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_10,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201250005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Deprecate bpf_object__open_buffer() API in favor of the unified
opts bpf_object__open_mem() API.

Signed-off-by: Christy Lee <christylee@fb.com>
---
 tools/lib/bpf/libbpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 94670066de62..281cb19591e5 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -180,6 +180,7 @@ bpf_object__open_mem(const void *obj_buf, size_t obj_=
buf_sz,
 		     const struct bpf_object_open_opts *opts);
=20
 /* deprecated bpf_object__open variants */
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_object__open_mem() instead")
 LIBBPF_API struct bpf_object *
 bpf_object__open_buffer(const void *obj_buf, size_t obj_buf_sz,
 			const char *name);
--=20
2.30.2

