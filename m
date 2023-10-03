Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2432916
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Oct 2023 05:49:35 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7032BB4
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Oct 2023 22:49:34 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3935kDaN026371;
	Tue, 3 Oct 2023 05:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=2fSfbAVxlBQN+M501ObjJ2ZT7cKGIthdcAlyKazz4XI=;
 b=F5EvC/7Dt7C5wrQWiNs/p6WaVhJgOY2cMQYcESHFkybl2R5DxsRlu1f8mJk0vVqAU6Ok
 2jb6i2CRz6qB03hE/oov9Flw1L7cEz6xyB47Iml0H0BlJdpeUc41RzlYBvzusa3hA9NN
 DcdBBR7ofjQbRDvH2EkpkJ2cThxudHgeyN5XD6sc26Ds8W9XAW0MT4d6kYZ06Co+f8BH
 EyTUuq5ltMPw7U3fKB/r+/Q7zGRoYbsIymb5EEahfGSdcREMaxLlVSr9ear2F+n5lsvN
 EWsTu0K3YfmJY7rPVEj3zfwMk1KO8Ml5yFJ/vWWn6ZnOYtViZnL83RmWIpeW4b4/X/DO ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgd39r1cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Oct 2023 05:49:31 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3935nVKS000997;
	Tue, 3 Oct 2023 05:49:31 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgd39r1cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Oct 2023 05:49:31 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39344QJI010931;
	Tue, 3 Oct 2023 05:49:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf0q1en2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Oct 2023 05:49:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3935nRjg13370088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Oct 2023 05:49:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 862F82004D;
	Tue,  3 Oct 2023 05:49:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADBF620049;
	Tue,  3 Oct 2023 05:49:25 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  3 Oct 2023 05:49:25 +0000 (GMT)
Date: Tue, 3 Oct 2023 11:19:17 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v4 1/4] perf check: introduce check subcommand
Message-ID: <5mglaqezgyyjw4hpjxdlhpcs5hud4owjvuhz6fqajffcitthys@hx7er5wvpbmd>
References: <20231002173253.70891-1-adityag@linux.ibm.com>
 <20231002173253.70891-2-adityag@linux.ibm.com>
 <CAM9d7chMvBZgwFyRnax+=2Dg=dSb015qEer4t+hWes_uDhHMzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chMvBZgwFyRnax+=2Dg=dSb015qEer4t+hWes_uDhHMzQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nkr0Zdz-hJAu_IYDnNOgWF3Ra3vf3JKA
X-Proofpoint-GUID: _fhfgtPn8VTBuSBwNYsUaQIQkZqXn9l6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_03,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 09:35:37PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Oct 2, 2023 at 10:33 AM Aditya Gupta <adityag@linux.ibm.com> wrote:
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
> > 'perf check --feature' command is expected to have exit status of 0 if
> > feature is built-in, and 1 if it's not built-in or if feature is not known.
> >
> > An array 'supported_features' has also been introduced that can be used by
> > other commands like 'perf version --build-options', so that new features
> > can be added in one place, with the array
> >
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> 
> [SNIP]
> > +/**
> > + * check whether "feature" is built-in with perf
> > + *
> > + * returns:
> > + *    0: Built-in
> > + *    1: NOT built-in or Feature not known
> > + */
> 
> There's a miscommunication here (again)..
> I'm ok that has_support() return 1 for builtin features.
> 
> > +static int has_support(const char *feature)
> > +{
> > +       for (int i = 0; supported_features[i].name; ++i) {
> > +               if ((strcmp(feature, supported_features[i].name) == 0) ||
> > +                   (strcmp(feature, supported_features[i].macro) == 0)) {
> > +                       if (!quiet)
> > +                               STATUS(supported_features[i]);
> > +                       return !supported_features[i].is_builtin;
> > +               }
> > +       }
> > +
> > +       if (!quiet)
> > +               color_fprintf(stdout, PERF_COLOR_RED, "Feature not known: %s", feature);
> > +
> > +       return 1;
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
> 
> And you can just change this part to confirm the shell standard.
> 
>     if (check.feature)
>         return !has_supporf(check.feature);

Oh, okay. Got it, thanks for including this diff, it made it clear :)

> 
> With that change, you can add my s-o-b to the series,
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks for the tag, will include the Acked by in V5.

Thanks,
- Aditya Gupta

> 
> Thanks,
> Namhyung
> 
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
> > index d3fc8090413c..6514f4121c49 100644
> > --- a/tools/perf/perf.c
> > +++ b/tools/perf/perf.c
> > @@ -50,6 +50,7 @@ static struct cmd_struct commands[] = {
> >         { "archive",    NULL,   0 },
> >         { "buildid-cache", cmd_buildid_cache, 0 },
> >         { "buildid-list", cmd_buildid_list, 0 },
> > +       { "check",      cmd_check,      0 },
> >         { "config",     cmd_config,     0 },
> >         { "c2c",        cmd_c2c,        0 },
> >         { "diff",       cmd_diff,       0 },
> > --
> > 2.41.0
> >
