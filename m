Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBAF39B94D
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500108; cv=none; b=jAdyKLKhhuFgMnVbe8KToT7r/yqu3veNWX7LBCB5htddCirwwNZWITyz2F1qWpvfXWVN2rSkIIjjdw9aPDW2Ac8/M/CVI5CT6POC9DYB+unlDKGWlm1xxln2r+a1rTp9kYgXjp/4G9EpaEjDxC1A05m+GT3VAnYjbAcpUcb1nRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500108; c=relaxed/simple;
	bh=M/lqkBFAUH1YROmNIhIaEE3M1oFHgguIw1ESqeJRujU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RKaieCJjEm/Mt9qPWFWBKkPE7hTNPrGuSQDIEzSvgCQPMSSEeM/5qtCjKKzYGs++/bvttY0GS0coD/iRzHpzEfwIfHgeLiGpsioXIs4ZL88NIHRi2GGuAjinL/bpB9ulU/J7CmN63laP8zYKgNcO5kjCn3hCNIqJaBd9Ft5PFcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2TZCbrz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2TZCbrz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EA61F00893;
	Wed,  3 Jun 2026 15:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500106;
	bh=wup70YDV8lzYyBpA4ML1EF2lbVT7TRiU/lj1LR6Qnt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A2TZCbrzgr6f+LYOSDrsF+3i/E+MqmFkyeJw/ZHgFtDfwNQITzJLCzITf8nLoZBo4
	 MLPPgJNa85zJXX00S32rtQTCb3oMluBwvou5eLJJsuepWrEcQ7vgBegIebFVCfuaMC
	 iEnLNNkNJff6wVXTOBw1C61eggHi0jnkcTtWKOj8mFSLO8znKcCM2zZzd4Sl7TPEPz
	 FBVHrjoy1BYoYyVtlt0e+VzMVtN6nTVbRUPR0L1ZZ8AsPxQQbNVJCN7w7sxzRThjtP
	 ZsMN0MmlSYo2jCZtFbX9JKNWniuwiV8hAp/kCX93s6iH2hmrkdC+J70KYEHtvh3IOV
	 Qkhhiol3qKEaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] perf/arm-cmn: Move DTM index data out of
 hw_perf_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aviv Bakal" <avivb@amazon.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260603150025.30980-2-avivb@amazon.com>
References: <20260603150025.30980-2-avivb@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:21:46 +0000
Message-Id: <20260603152146.92EA61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Type confusion in `arm_cmn_validate_group` allows arbitrary ke=
rnel memory read and out-of-bounds heap write via mixed PMU event groups.
--

commit 5cf0bca45fce2ef5c66d58f875b8d4b3f7c015e0
Author: Robin Murphy <robin.murphy@arm.com>

perf/arm-cmn: Move DTM index data out of hw_perf_event

This commit moves the DTM index arrays and watchpoint tracking out of
hw_perf_event into separate dynamically allocated memory structures. This
change is intended to accommodate growing CMN configurations without exceed=
ing
the limits of hw_perf_event.

> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index f5305c8fdca43..f1978a53d1c19 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c

[ ... ]

> @@ -1787,6 +1809,11 @@ static int arm_cmn_event_init(struct perf_event *e=
vent)
>  	if (type =3D=3D CMN_TYPE_DTC)
>  		return arm_cmn_validate_group(cmn, event);
> =20

[Severity: Critical]
This isn't a bug introduced by this patch, but could this lead to a type
confusion and out-of-bounds write when validating groups with mixed PMU eve=
nts?

When arm_cmn_validate_group() iterates over the group's siblings, it doesn't
verify that sibling->pmu =3D=3D event->pmu. If a sibling is a hardware even=
t from
a different PMU, it passes it to arm_cmn_val_add_event():

drivers/perf/arm-cmn.c:arm_cmn_validate_group() {
...
    for_each_sibling_event(sibling, leader)
        arm_cmn_val_add_event(cmn, val, sibling);
...
}

Inside arm_cmn_val_add_event(), it casts the sibling's hw_perf_event to an
arm_cmn_hw_event. Since userspace controls attr.config, it can overlap with
the hw->dn pointer, allowing arbitrary kernel memory reads:

drivers/perf/arm-cmn.c:arm_cmn_val_add_event() {
...
    for_each_hw_dn(hw, dn, i) {
        int wp_idx, dtm =3D dn->dtm, sel =3D hw->filter_sel;

        val->dtm_count[dtm]++;
...
}

Because the read byte dtm can be up to 255 and the array bounds are
CMN_MAX_DTMS (188), does this enable a controllable out-of-bounds write on
the kernel heap?

> +	event->destroy =3D arm_cmn_event_destroy;
> +	hw->dtm_idx =3D arm_cmn_alloc_dtm_idx();
> +	if (!hw->dtm_idx)
> +		return -ENOMEM;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603150025.3098=
0-1-avivb@amazon.com?part=3D1
