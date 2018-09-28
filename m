From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3] perf test: S390 does not support watchpoints in test
 22
Date: Fri, 28 Sep 2018 11:52:34 -0300
Message-ID: <20180928145234.GK25764@kernel.org>
References: <20180928105335.67179-1-tmricht@linux.ibm.com>
 <f1ee3dc0-6b96-c7e5-f449-caabd3bf7f8a@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f1ee3dc0-6b96-c7e5-f449-caabd3bf7f8a@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Sep 28, 2018 at 04:43:06PM +0530, Ravi Bangoria escreveu:
> On 09/28/2018 04:23 PM, Thomas Richter wrote:
> > S390 does not support the perf_event_open system call for
> > attribute type PERF_TYPE_BREAKPOINT. This results in test
> > failure for test 22:

> > [root@s8360046 perf]# ./perf test 22
> > 22: Watchpoint                                :
> > 22.1: Read Only Watchpoint                    : FAILED!
> > 22.2: Write Only Watchpoint                   : FAILED!
> > 22.3: Read / Write Watchpoint                 : FAILED!
> > 22.4: Modify Watchpoint                       : FAILED!
> > [root@s8360046 perf]#

> > Add s390 support to avoid these tests being executed on
> > s390 platform:

> > [root@s8360046 perf]# ./perf test 22
> > [root@s8360046 perf]# ./perf test -v 22
> > 22: Watchpoint                                : Disabled
> > [root@s8360046 perf]#

> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
 
> Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Thanks, applying.

Just one nit, in cases like this I think a Reviewed-by tag fits better
than a Acked-by, as per Documentation/process/submitting-patches.rst:

--------------

Reviewed-by:, instead, indicates that the patch has been reviewed and found
acceptable according to the Reviewer's Statement:

Reviewer's statement of oversight
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

By offering my Reviewed-by: tag, I state that:

         (a) I have carried out a technical review of this patch to
             evaluate its appropriateness and readiness for inclusion into
             the mainline kernel.

         (b) Any problems, concerns, or questions relating to the patch
             have been communicated back to the submitter.  I am satisfied
             with the submitter's response to my comments.

         (c) While there may be things that could be improved with this
             submission, I believe that it is, at this time, (1) a
             worthwhile modification to the kernel, and (2) free of known
             issues which would argue against its inclusion.

         (d) While I have reviewed the patch and believe it to be sound, I
             do not (unless explicitly stated elsewhere) make any
             warranties or guarantees that it will achieve its stated
             purpose or function properly in any given situation.

A Reviewed-by tag is a statement of opinion that the patch is an
appropriate modification of the kernel without any remaining serious
technical issues.  Any interested reviewer (who has done the work) can
offer a Reviewed-by tag for a patch.  This tag serves to give credit to
reviewers and to inform maintainers of the degree of review which has been
done on the patch.  Reviewed-by: tags, when supplied by reviewers known to
understand the subject area and to perform thorough reviews, will normally
increase the likelihood of your patch getting into the kernel.

----------

While an Acked-by conveys just some quick look was performed, and in
this case you did what Reviewed-by signifies, I think.

I'm tentatively converting this Acked-by to a Reviewed-by, please let me
know if you disagree,

Thanks a lot!

- Arnaldo
