Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6B33F1
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 10:18:20 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243EF59DB
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 03:18:18 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RAICQh024631;
	Wed, 27 Sep 2023 10:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=iz1vkYQ8dDHShoiZlFyl4hiLM8T8oPnWIb/pVpv+/ys=;
 b=lMod8Ig23IQ+JklDgT8aL8VOlXOCmCJCamtonrjap0Wc4Je+St3jFonItubQSTe+n5SW
 Jj9O+TKm1WZCPS3yPJ6ggV4fk1+ks53y1IXEHZvyGlgyjjptfb5sVScum6l/suxkEQXN
 Mmo++Lh271HaMEl9GvO9XME2I6N9Pal+WGeu06l/G48LIPLukfwUf7u5HtwrX2sfcog1
 0wIN6tvurO3sBSQ2F6jeEDHtWwr3wtI7+qjXJ6NX8qTa4SO0DFCqthLq5P7TEBT+lILJ
 IGc4vXycPEDyaVKVldnp5i8FWIsmrsnf9bsW6cTYHr2NkfKkBJ9t9U8EHy/rJdqm10hE Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcj05rus4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Sep 2023 10:11:54 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RA90qU023601;
	Wed, 27 Sep 2023 10:10:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcj05rjya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Sep 2023 10:10:22 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38R9qQUQ030746;
	Wed, 27 Sep 2023 10:04:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjk26hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Sep 2023 10:04:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38RA40MF16908966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Sep 2023 10:04:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A67D02004D;
	Wed, 27 Sep 2023 10:04:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0B9D2004B;
	Wed, 27 Sep 2023 10:03:58 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 27 Sep 2023 10:03:58 +0000 (GMT)
Date: Wed, 27 Sep 2023 15:33:54 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v2 1/4] perf check: introduce check subcommand
Message-ID: <cvjy23kygfwv6hl4kw6k5ob7hezmxmsx7owjso5hqmuno2oz4a@3fcbymhjkklo>
References: <20230920192847.975897-1-adityag@linux.ibm.com>
 <20230920192847.975897-2-adityag@linux.ibm.com>
 <CAM9d7cihonpzY7pW1o9V1q5Ja2SAD+frcjVESBw=073LpuokLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cihonpzY7pW1o9V1q5Ja2SAD+frcjVESBw=073LpuokLA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gFpty4_ZjohRq4v-BIjxfyQhsXBqUjs2
X-Proofpoint-GUID: f8r2DNcwxQY84n6gvV1mdFoTP7733kIv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_05,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Namhyung,
Thanks for the reviews. Also, sorry for the delays in my replies.

On Tue, Sep 26, 2023 at 05:29:35PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Sep 20, 2023 at 12:29 PM Aditya Gupta <adityag@linux.ibm.com> wrote:
> >
> > Currently the presence of a feature is checked with a combination of
> > perf version --build-options and greps, such as:
> >
> >     perf version --build-options | grep " on .* HAVE_FEATURE"
> >
> > Instead of this, introduce a subcommand "perf check --feature", with which
> > scripts can test for presence of a feature, such as:
> >
> >     perf check --feature HAVE_FEATURE
> >
> > 'perf check --feature' command is expected to have exit status of 1 if feature is
> > built-in, and 0 if not, -2 if feature is not known.
> >
> > An array 'supported_features' has also been introduced that can be
> > used by other commands like 'perf version --build-options', so that
> > new features can be added in one place, with the array
> >
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> 
> [SNIP]
> > +/**
> > + * check whether "feature" is built-in with perf
> > + * returns:
> > + *   -1: Feature not known
> > + *    0: Built-in
> > + *    1: NOT Built in
> 
> It seems not intuitive.  I'd return 1 if it's builtin.

Yes, initially it used to return 1 (TRUE) if builtin, 0 if not (FALSE).
The idea was that scripts were using 'grep "HAVE_FEATURE" && return 1', so to
match the grep behaviour (if search is true, it returns 0), I changed it.

That said, I do agree with your intuitive point, will change it back in V3.

> Maybe we can return 0 for unknown ones too.

Sure, that also removes the need for 'res' as you suggested later.

> 
> > + */
> > +static int has_support(const char *feature)
> > +{
> > +       int res = -1;
> > +
> > +       for (int i = 0; supported_features[i].name; ++i) {
> > +               if ((strcmp(feature, supported_features[i].name) == 0) ||
> > +                       (strcmp(feature, supported_features[i].macro) == 0)) {
> 
> Please align it to the previous strcmp().

Oh sorry, missed it as it was showing aligned for me (due to tab). Will align it
in V3.

> 
> 
> > +                       res = supported_features[i].is_builtin;
> > +                       if (!quiet)
> > +                               STATUS(supported_features[i]);
> > +                       break;
> 
> Why not return right here?

Sure, can return here.

> 
> 
> > +               }
> > +       }
> > +
> > +       if (res == -1) {
> > +               if (!quiet)
> > +                       color_fprintf(stdout, PERF_COLOR_RED, "Feature not known: %s", feature);
> > +               return -1;
> > +       }
> 
> Then you don't even need the 'res' variable.

Yup, with the -1 and 0 both be 0, I will remove the 'res'.

> 
> > +
> > +       return !res;
> > +}
> > +
> > +int cmd_check(int argc, const char **argv)
> > +{
> > +       argc = parse_options(argc, argv, check_options, check_usage,
> > +                            PARSE_OPT_STOP_AT_NON_OPTION);
> > +
> > +       if (!quiet)
> > +               printf("perf check %s\n", perf_version_string);
> > +
> > +       if (check.feature)
> > +               return has_support(check.feature);
> > +
> > +       return 0;
> > +}
> > diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
> > index f2ab5bae2150..9f895981bc9e 100644
> > --- a/tools/perf/builtin.h
> > +++ b/tools/perf/builtin.h
> > @@ -2,6 +2,23 @@
> >  #ifndef BUILTIN_H
> >  #define BUILTIN_H
> >
> > +#include <stddef.h>
> > +#include <linux/compiler.h>
> > +#include <tools/config.h>
> > +
> > +struct feature_support {
> > +       const char *name;
> > +       const char *macro;
> > +       int is_builtin;
> > +};
> > +
> > +#define FEATURE_SUPPORT(name_, macro_) { \
> > +       .name = name_,                       \
> > +       .macro = #macro_,                    \
> > +       .is_builtin = IS_BUILTIN(macro_) }
> > +
> > +extern struct feature_support supported_features[];
> > +
> >  void list_common_cmds_help(void);
> >  const char *help_unknown_cmd(const char *cmd);
> >
> > @@ -9,6 +26,7 @@ int cmd_annotate(int argc, const char **argv);
> >  int cmd_bench(int argc, const char **argv);
> >  int cmd_buildid_cache(int argc, const char **argv);
> >  int cmd_buildid_list(int argc, const char **argv);
> > +int cmd_check(int argc, const char **argv);
> >  int cmd_config(int argc, const char **argv);
> >  int cmd_c2c(int argc, const char **argv);
> >  int cmd_diff(int argc, const char **argv);
> > diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> > index d3fc8090413c..83dc0ac42fdb 100644
> > --- a/tools/perf/perf.c
> > +++ b/tools/perf/perf.c
> > @@ -50,6 +50,7 @@ static struct cmd_struct commands[] = {
> >         { "archive",    NULL,   0 },
> >         { "buildid-cache", cmd_buildid_cache, 0 },
> >         { "buildid-list", cmd_buildid_list, 0 },
> > +       { "check", cmd_check, 0 },
> 
> Please align this.

It should be aligned, on my system it's showing one tab before this, as the
other lines also do, will align it in next version.

Also namhyung, I moved the definition of the 'supported_features' array to
builtin-check.c, and is also accessed in builtin-version.c does that seem good
to you ?

Thanks,
- Aditya Gupta

> 
> Thanks,
> Namhyung
> 
> 
> >         { "config",     cmd_config,     0 },
> >         { "c2c",        cmd_c2c,        0 },
> >         { "diff",       cmd_diff,       0 },
> > --
> > 2.41.0
> >
