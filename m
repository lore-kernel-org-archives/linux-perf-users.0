From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH 07/16] tools headers uapi: Update i915_drm.h
Date: Mon, 07 Jan 2019 12:53:38 +0200
Message-ID: <154685841813.25474.9319368316047420636@jlahtine-desk.ger.corp.intel.com>
References: <20190104183337.12771-1-acme@kernel.org>
 <20190104183337.12771-8-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104183337.12771-8-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, Jiri Olsa <jolsa@kernel.org>, Lionel Landwerlin <lionel.g.landwerlin@intel.com>, Namhyung Kim <namhyung@kernel.org>, Jani Nikula <jani.nikula@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
List-Id: linux-perf-users.vger.kernel.org

Quoting Arnaldo Carvalho de Melo (2019-01-04 20:33:28)
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To get the changes in these csets:
> 
>   fe841686470d Revert "drm/i915/perf: add a parameter to control the size of OA buffer"
>   cd956bfcd0f5 drm/i915/perf: add a parameter to control the size of OA buffer
>   4bdafb9ddfa4 drm/i915: Remove i915.enable_ppgtt override
> 
> Not one of them result in any changes in tools/perf/, this is just to
> silence this perf build warning:
> 
>   Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
>   diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lkml.kernel.org/n/tip-mdw7ta6qz7d2rl77gf00uqe8@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

This is:

Acked-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

I assume this'll be merged through tip tree along the other changes.

Regards, Joonas

> ---
>  tools/include/uapi/drm/i915_drm.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
> index a4446f452040..298b2e197744 100644
> --- a/tools/include/uapi/drm/i915_drm.h
> +++ b/tools/include/uapi/drm/i915_drm.h
> @@ -412,6 +412,14 @@ typedef struct drm_i915_irq_wait {
>         int irq_seq;
>  } drm_i915_irq_wait_t;
>  
> +/*
> + * Different modes of per-process Graphics Translation Table,
> + * see I915_PARAM_HAS_ALIASING_PPGTT
> + */
> +#define I915_GEM_PPGTT_NONE    0
> +#define I915_GEM_PPGTT_ALIASING        1
> +#define I915_GEM_PPGTT_FULL    2
> +
>  /* Ioctl to query kernel params:
>   */
>  #define I915_PARAM_IRQ_ACTIVE            1
> -- 
> 2.20.1
> 
