From: Arun Sharma <arun@sharma-home.net>
Subject: Re: How does take use of EventName and UnitMask?
Date: Thu, 17 Mar 2011 14:03:25 -0700
Message-ID: <AANLkTi=e_gB-hLqxf4Cyoh9u+Cb4pdxpfGJZrZd2gKf=@mail.gmail.com>
References: <tencent_5D9EFCFD67548CB92638B8BA@qq.com>
	<AANLkTinjmVwtWpAnGPyehn0kT6U3KQWKPU0iz=Fb45aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <perfmon2-devel-bounces@lists.sourceforge.net>
In-Reply-To: <AANLkTinjmVwtWpAnGPyehn0kT6U3KQWKPU0iz=Fb45aA@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/perfmon2-devel>,
	<mailto:perfmon2-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=perfmon2-devel>
List-Post: <mailto:perfmon2-devel@lists.sourceforge.net>
List-Help: <mailto:perfmon2-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/perfmon2-devel>,
	<mailto:perfmon2-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: perfmon2-devel-bounces@lists.sourceforge.net
To: Easley <ugiwgh@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, chenwj <chenwj@iis.sinica.edu.tw>, perfmon2-devel <perfmon2-devel@lists.sourceforge.net>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Mar 17, 2011 at 8:43 AM, Arun Sharma <arun@sharma-home.net> wrote:
>
> Stephane has disabled the uncore event support in libpfm4 (since the
> patch is still not upstream yet). But by uncommenting 2-3 lines of
> code, you should be able to get uncore events working.
>

This is the patch I'm using for uncore events with perf + libpfm4.

diff --git a/include/perfmon/perf_event.h b/include/perfmon/perf_event.h
index 4ba6738..ef68265 100644
--- a/include/perfmon/perf_event.h
+++ b/include/perfmon/perf_event.h
@@ -46,6 +46,7 @@ enum perf_type_id {
        PERF_TYPE_HW_CACHE      = 3,
        PERF_TYPE_RAW           = 4,
        PERF_TYPE_BREAKPOINT    = 5,
+       PERF_TYPE_UNCORE        = 6,
        PERF_TYPE_MAX
 };

diff --git a/lib/pfmlib_intel_x86_perf_event.c
b/lib/pfmlib_intel_x86_perf_event.c
index ab282dd..b35dccd 100644
--- a/lib/pfmlib_intel_x86_perf_event.c
+++ b/lib/pfmlib_intel_x86_perf_event.c
@@ -81,10 +81,7 @@ pfm_intel_nhm_unc_get_perf_encoding(void *this,
pfmlib_event_desc_t *e)
        if (ret != PFM_SUCCESS)
                return ret;

-#if 0
-       /* XXX: uncomment when uncore support is upstream */
        attr->type = PERF_TYPE_UNCORE;
-#endif
        attr->config = e->codes[0];
        /*
         * uncore measures at all priv levels
diff --git a/lib/pfmlib_perf_event.c b/lib/pfmlib_perf_event.c
index 824f9a5..d2eea5e 100644
--- a/lib/pfmlib_perf_event.c
+++ b/lib/pfmlib_perf_event.c
@@ -157,7 +157,7 @@ pfmlib_perf_event_encode(void *this, const char
*str, int dfl_plm, void *data)

        attr->exclude_user = !(plm & PFM_PLM3);
        attr->exclude_kernel = !(plm & PFM_PLM0);
-       attr->exclude_hv = !(plm & PFM_PLMH);
+       //attr->exclude_hv = !(plm & PFM_PLMH);

        __pfm_vbprintf("PERF[type=%x config=0x%"PRIx64" config1=0x%"PRIx64
                        " e_u=%d e_k=%d e_hv=%d period=%"PRIu64" freq=%d"

 -Arun

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
