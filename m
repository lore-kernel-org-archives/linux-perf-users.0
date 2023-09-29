Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B20C15C3
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 16:42:58 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BDE199
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 09:42:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 2CBEE5C0212;
	Fri, 29 Sep 2023 12:42:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 29 Sep 2023 12:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=astier.eu; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1696005775; x=1696092175; bh=GO
	7Crkz9eikT2baGgiq9fmbMz1/3hGWKTVGxkoXWalA=; b=fj18Zdh0WErRYTaWkJ
	BhV+qwNdV6xUv20AjgbpCvMc1oSRTrxZoFKUWzElbw4E0Ry4x/i4zAHjSmCqp1ef
	aPgB7j2gzOxTfzhkV8EKPm1Havy+owYR/BLTU7O2wpNF6RDc4SJIsW0gLVfWgr9m
	meP7IZVhV75A4D7qj327uiSCCq9FtBK7pd4ZzG7G2PR3GKw16+UVHyEl5EB85BsQ
	U6p6ldcbKGRBfEzhBoQSvE2jvBZlcW9nv8ppG+V4D6cyTqaTINeM3xcwsRcoK2fa
	tMtQkL6WjYZgxyza/7qKBAtElucaHpqVnrEzRLsCIaN58XWMR0VCApJInwyzrhiC
	eAYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1696005775; x=1696092175; bh=GO7Crkz9eikT2
	baGgiq9fmbMz1/3hGWKTVGxkoXWalA=; b=I03XV3mCSbJMqyuvunaD6QTFSsJpR
	a3uRvqzsZYlV/QkQcmu4dRdnJWDi47o70AmfAXr9mKdGVOwyw1YX6HN/YGtuLN2i
	XRVGY8gE3DhcHSCzzJT8Hm94gRODxMNQfMYyLR2lHQB9a1cLfM/eSzVb7rMFG0pB
	IPiCyold/31CalrUNjbnnC0xOYwCrWXOf3AD0FO4hS9uqfltt1LB5bINozghurnA
	jK2Frpd5B4ZkBSC1C6VMs98/1R32+y9UWTm977QiPEXt7UwcqakOldc0moNYkDIG
	qptKGetIRE3w1409ticmoFzK48eDIGEHqqn7iPMmLA0AsedAvlGzivlrg==
X-ME-Sender: <xms:jv4WZUwZPN9N6F9DKdwncJvnTaQRKq2tJZzrr7cyW-xfOO9pc3RJZA>
    <xme:jv4WZYQpV42o0ibtSx9U7tqvc0J1ubFkFE_DPHSlkaE6ABh7lBkntuAYe-kcS0F0L
    oPg-ogNhU9OeVLRVBU>
X-ME-Received: <xmr:jv4WZWWdeTKl9ziKtwbfww6wwOQbjmIlkygqdtD9fk9Om_rlONTmrdsH-wtG35NX3B1zAyc444l7Qz9yqTrgKsWpvsEe6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddvgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnihhs
    shgvucetshhtihgvrhcuoegrnhhishhsvgesrghsthhivghrrdgvuheqnecuggftrfgrth
    htvghrnhepleefgeeiieeitdejffejgfffieejhedthfdtieelveffgfdvtdffhfeutdfh
    feeinecuffhomhgrihhnpehsphhinhhitghsrdhnvghtpdhkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhhishhs
    vgesrghsthhivghrrdgvuh
X-ME-Proxy: <xmx:jv4WZSguMLWXXTpniPO_LK3Ghegla4XTz6rQGCrL9e6yPUwJbZlyIA>
    <xmx:jv4WZWBbH-jjRBDqn85txj3zkpq2qUl2dil54SEO0yKe_r79gjzimg>
    <xmx:jv4WZTLE2P7RoKib2ORfU9HvQog9rQ41cKBT7FGEhwWi0wVDZumWWA>
    <xmx:j_4WZRO-rsqrcjldvPksgW7Pzbx-Vj79dBkIp6LXEtWfiP3oC6l0Ag>
Feedback-ID: iccec46d4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Sep 2023 12:42:53 -0400 (EDT)
Date: Fri, 29 Sep 2023 18:42:50 +0200
From: Anisse Astier <anisse@astier.eu>
To: Ian Rogers <irogers@google.com>
Cc: Pierre Cheynier <p.cheynier@criteo.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@gmail.com>
Subject: Re: [6.5.4] perf: bison min. requirements
Message-ID: <ZRb+ijwAImHsrSnv@anisse-laptop>
References: <PAWPR04MB97658DD9546C6D0A141C0766EAC3A@PAWPR04MB9765.eurprd04.prod.outlook.com>
 <CAP-5=fVPVodcSkOHnJOrgkUO1QOnNTcsPMsfeEKvzjTvqA2K+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVPVodcSkOHnJOrgkUO1QOnNTcsPMsfeEKvzjTvqA2K+w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ian,

On Tue, Sep 26, 2023 at 02:28:50PM -0700, Ian Rogers wrote:
> On Tue, Sep 26, 2023 at 1:21???AM Pierre Cheynier <p.cheynier@criteo.com> wrote:
> >
> > Dear list,
> > At compiling 6.5.4 it seemed to me that this specific patch [1] added an implicit dependency to bison >= 3.7.4, due to usage of YYNOMEM.
> > Shouldn't this be part of Documentation/process/changes.rst?
> >
> > [1] https://www.spinics.net/lists/linux-perf-users/msg30885.html "perf parse-events: Separate YYABORT and YYNOMEM cases"
> >
> > Sorry for the noise, and thanks for inputs if ever I'm totally wrong here.
> 
> We have a workaround to #define YYNOMEM to YYABORT when Bison is
> less-than 3.8.1:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/Build?h=perf-tools-next#n323
> Perhaps you can help debug why this build logic isn't working for you?

This fix (commit 88cc47e245979 in perf-tools-next) has reached Linus'
tree, but not yet stable.

But code using a more recent Bison is now backported to v6.5.4 (stable
commit 0e8501c8a936e0b2ff4ffdff2c4866ba74969189, upstream commit
77cdd787fc45e3426b8e0b5038b85c276540dfb4), which is what causes the
build regression on older bison that Pierre reported.

Someone else noticed and already asked for a backport:
https://lore.kernel.org/all/CAM9d7cggeTaXR5VBD1BoPr9TLPoE7s9YSS2y0w-PGzTMAGsFWA@mail.gmail.com/

Kind regards,

Anisse
