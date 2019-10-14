From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf jvmti: Link against tools/lib/ctype.h to have weak
 strlcpy()
Date: Mon, 14 Oct 2019 11:27:19 -0300
Message-ID: <20191014142719.GK19627@kernel.org>
References: <20191008093841.59387-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191008093841.59387-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Oct 08, 2019 at 11:38:41AM +0200, Thomas Richter escreveu:
> The build of file libperf-jvmti.so succeeds but the resulting
> object fails to load:
> 
>  # ~/linux/tools/perf/perf record -k mono -- java  \
>       -XX:+PreserveFramePointer \
>       -agentpath:/root/linux/tools/perf/libperf-jvmti.so \
>        hog 100000 123450
>   Error occurred during initialization of VM
>   Could not find agent library /root/linux/tools/perf/libperf-jvmti.so
>       in absolute path, with error:
>       /root/linux/tools/perf/libperf-jvmti.so: undefined symbol: _ctype
> 
> Add the missing _ctype symbol into the build script.
> 
> Fixes: c5d048240e49 ("perf jvmti: Link against tools/lib/string.h to have weak strlcpy()")

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/jvmti/Build | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/jvmti/Build b/tools/perf/jvmti/Build
> index 1e148bbdf820..202cadaaf097 100644
> --- a/tools/perf/jvmti/Build
> +++ b/tools/perf/jvmti/Build
> @@ -2,7 +2,7 @@ jvmti-y += libjvmti.o
>  jvmti-y += jvmti_agent.o
>  
>  # For strlcpy
> -jvmti-y += libstring.o
> +jvmti-y += libstring.o libctype.o
>  
>  CFLAGS_jvmti         = -fPIC -DPIC -I$(JDIR)/include -I$(JDIR)/include/linux
>  CFLAGS_REMOVE_jvmti  = -Wmissing-declarations
> @@ -15,3 +15,7 @@ CFLAGS_libstring.o += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PE
>  $(OUTPUT)jvmti/libstring.o: ../lib/string.c FORCE
>  	$(call rule_mkdir)
>  	$(call if_changed_dep,cc_o_c)
> +
> +$(OUTPUT)jvmti/libctype.o: ../lib/ctype.c FORCE
> +	$(call rule_mkdir)
> +	$(call if_changed_dep,cc_o_c)
> -- 
> 2.21.0

-- 

- Arnaldo
