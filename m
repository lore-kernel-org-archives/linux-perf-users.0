Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DDF170A15;
	Wed, 22 Jan 2025 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513321; cv=none; b=ru1zeluQ+uHdxbAJo+5h5FCMSo21VASjM5LWtQ5IkP2cGejEaUX64jC6jnhj7HnOBe6wL3h8ozdiHhuWH+uMW1JCx22ZHq6afTfFpfaP5pE6Xh8fQPpPVRM9HrTSwIPfMFL9moTHfacv3rzDhJFVNCh7CjXzDSPT98jyHnDZf/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513321; c=relaxed/simple;
	bh=hQr70nJFPpr3IR+3WHkCZaeOfn9y4cOzZG7LuQnlPEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAXD+LB6si5UDhVD6JWOpa2OXEc8NP9V6l49cVaqngm/nfS9D58I9ibEn20KSJvWV3qL0XFNZi8+D2dTle8abNaGTk8QsJQ12ffZBos0UNT6fSMPOeeOBvIMGE0pZo4H+T/M9K7aYq8aZo6YqN6Tc/3xJyhTaTwWj1SRhO0R5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItUIDsij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItUIDsij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024BDC4CEDF;
	Wed, 22 Jan 2025 02:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513319;
	bh=hQr70nJFPpr3IR+3WHkCZaeOfn9y4cOzZG7LuQnlPEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ItUIDsij4Q3QK4chCyynXQ5OX6zsCbbhiEqi47tcIdjaGeVkmyiMncRov000ZczHo
	 09u7LMbhPeu4UU8pDM/0crN2ZxLyqEWqwphBHmdZHd4gG186BYbPTHNaUK6k4/vgOf
	 HTSbivH0WepBFJ+WvHSurwnzVQBD6xVdKxCiIFpDVi9iw+QG8lhG1vZ+HmWi3sTD1q
	 nn8oe7RItl7RZfOEc3nAubB60vY6AUH00QlJsY3d2fNc5sgqG90TNssMSzUo9GS+Ry
	 gSJVw3pxsWBNAjO5Bv1jHGrjObY89IRSK67a8DAPgpCohrbotHiXy2okZF1YmIpnzO
	 IjiIOJ+eh9QgA==
Date: Tue, 21 Jan 2025 18:35:17 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 00/39] unwind, perf: sframe user space unwinding
Message-ID: <20250122023517.lmztuocecdjqzfhc@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>

On Tue, Jan 21, 2025 at 06:30:52PM -0800, Josh Poimboeuf wrote:
> For testing with user space, here are the latest binutils fixes:
> 
>   1785837a2570 ("ld: fix PR/32297")
>   938fb512184d ("ld: fix wrong SFrame info for lazy IBT PLT")
>   47c88752f9ad ("ld: generate SFrame stack trace info for .plt.got")
> 
> An out-of-tree glibc patch is also needed -- will attach in a reply.

Latest out-of-tree glibc patch below:

diff --git a/elf/dl-load.c b/elf/dl-load.c
index e986d7faab..5a593c2126 100644
--- a/elf/dl-load.c
+++ b/elf/dl-load.c
@@ -29,6 +29,7 @@
 #include <bits/wordsize.h>
 #include <sys/mman.h>
 #include <sys/param.h>
+#include <sys/prctl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <gnu/lib-names.h>
@@ -87,6 +88,9 @@ struct filebuf
 
 #define STRING(x) __STRING (x)
 
+#ifndef PT_GNU_SFRAME
+#define PT_GNU_SFRAME 0x6474e554
+#endif
 
 /* This is the decomposed LD_LIBRARY_PATH search path.  */
 struct r_search_path_struct __rtld_env_path_list attribute_relro;
@@ -1186,6 +1190,11 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
 	  l->l_relro_addr = ph->p_vaddr;
 	  l->l_relro_size = ph->p_memsz;
 	  break;
+
+	case PT_GNU_SFRAME:
+	  l->l_sframe_start = ph->p_vaddr;
+	  l->l_sframe_end   = ph->p_vaddr + ph->p_memsz;
+	  break;
 	}
 
     if (__glibc_unlikely (nloadcmds == 0))
@@ -1236,6 +1245,26 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
 	l->l_map_start = l->l_map_end = 0;
 	goto lose;
       }
+
+#define PR_ADD_SFRAME 77
+    if (l->l_sframe_start != 0)
+    {
+      l->l_sframe_start += l->l_addr;
+      l->l_sframe_end   += l->l_addr;
+
+      for (size_t i = 0; i < nloadcmds; i++)
+      {
+	struct loadcmd *c = &loadcmds[i];
+
+	if (c->prot & PROT_EXEC)
+	{
+	  ElfW(Addr) text_start = l->l_addr + c->mapstart;
+	  ElfW(Addr) text_end   = l->l_addr + c->mapend;
+
+	  __prctl(PR_ADD_SFRAME, l->l_sframe_start, l->l_sframe_end, text_start, text_end);
+	}
+      }
+    }
   }
 
   if (l->l_ld != NULL)
diff --git a/elf/dl-unmap-segments.h b/elf/dl-unmap-segments.h
index f16f4d7ded..dd14162e00 100644
--- a/elf/dl-unmap-segments.h
+++ b/elf/dl-unmap-segments.h
@@ -21,14 +21,20 @@
 
 #include <link.h>
 #include <sys/mman.h>
+#include <sys/prctl.h>
 
 /* _dl_map_segments ensures that any whole pages in gaps between segments
    are filled in with PROT_NONE mappings.  So we can just unmap the whole
    range in one fell swoop.  */
 
+#define PR_REMOVE_SFRAME 78
+
 static __always_inline void
 _dl_unmap_segments (struct link_map *l)
 {
+  if (l->l_sframe_start != 0)
+    __prctl(PR_REMOVE_SFRAME, l->l_sframe_start, NULL, NULL, NULL);
+
   __munmap ((void *) l->l_map_start, l->l_map_end - l->l_map_start);
 }
 
diff --git a/elf/setup-vdso.h b/elf/setup-vdso.h
index 888e1e4897..2a6bb9b944 100644
--- a/elf/setup-vdso.h
+++ b/elf/setup-vdso.h
@@ -16,6 +16,11 @@
    License along with the GNU C Library; if not, see
    <https://www.gnu.org/licenses/>.  */
 
+#include <sys/prctl.h>
+#ifndef PT_GNU_SFRAME
+#define PT_GNU_SFRAME 0x6474e554
+#endif
+
 static inline void __attribute__ ((always_inline))
 setup_vdso (struct link_map *main_map __attribute__ ((unused)),
 	    struct link_map ***first_preload __attribute__ ((unused)))
@@ -52,6 +57,14 @@ setup_vdso (struct link_map *main_map __attribute__ ((unused)),
 	      if (ph->p_vaddr + ph->p_memsz >= l->l_map_end)
 		l->l_map_end = ph->p_vaddr + ph->p_memsz;
 	    }
+	  else if (ph->p_type == PT_GNU_SFRAME)
+	    {
+	      if (! l->l_sframe_start)
+		{
+		  l->l_sframe_start = ph->p_vaddr;
+		  l->l_sframe_end   = ph->p_vaddr + ph->p_memsz;
+		}
+	    }
 	  else
 	    /* There must be no TLS segment.  */
 	    assert (ph->p_type != PT_TLS);
@@ -74,6 +87,15 @@ setup_vdso (struct link_map *main_map __attribute__ ((unused)),
       l->l_local_scope[0]->r_nlist = 1;
       l->l_local_scope[0]->r_list = &l->l_real;
 
+#define PR_ADD_SFRAME 77
+      if (l->l_sframe_start != 0)
+	{
+	  l->l_sframe_start += l->l_addr;
+	  l->l_sframe_end   += l->l_addr;
+
+	  __prctl(PR_ADD_SFRAME, l->l_sframe_start, l->l_sframe_end, l->l_addr, l->l_map_end);
+	}
+
       /* Now that we have the info handy, use the DSO image's soname
 	 so this object can be looked up by name.  */
       if (l->l_info[DT_SONAME] != NULL)
diff --git a/include/link.h b/include/link.h
index 5ed445d5a6..e94390b29e 100644
--- a/include/link.h
+++ b/include/link.h
@@ -345,6 +345,9 @@ struct link_map
     ElfW(Addr) l_relro_addr;
     size_t l_relro_size;
 
+    ElfW(Addr) l_sframe_start;
+    ElfW(Addr) l_sframe_end;
+
     unsigned long long int l_serial;
   };
 
