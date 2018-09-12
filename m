From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/7] perf/urgent fixes
Date: Wed, 12 Sep 2018 21:10:54 +0200
Message-ID: <20180912191054.GA63360@gmail.com>
References: <20180912185509.32187-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912185509.32187-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>, Brian Starkey <brian.starkey@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@gmail.com>, David Hildenbrand <david@redhat.com>, "David S . Miller" <davem@davemloft.net>, Dongjiu Geng <gengdongjiu@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Anholt <eric@anholt.net>, Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>, Hendrik Brueckner <brueckner@linux.v>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 02e184476eff848273826c1d6617bb37e5bcc7ad:
> 
>   perf/core: Force USER_DS when recording user stack data (2018-09-10 14:01:46 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.19-20180912
> 
> for you to fetch changes up to 03db8b583d1c3c84963e08e2abf6c79081da5c31:
> 
>   perf tools: Fix maps__find_symbol_by_name() (2018-09-11 14:12:51 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Fix finding a symbol by name when multiple maps use the same backing DSO,
>   so we must first see if that symbol name is in the DSO, then see if it is
>   inside the range of addresses for that specific map (Adrian Hunter)
> 
> - Update the tools copies of UAPI headers, which silences the warnings
>   emitted when building the tools and in some cases, like for the new
>   KVM ioctls, results in 'perf trace' being able to translate that
>   ioctl number to a string (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (1):
>       perf tools: Fix maps__find_symbol_by_name()
> 
> Arnaldo Carvalho de Melo (6):
>       tools headers uapi: Update tools's copy of linux/perf_event.h
>       tools headers uapi: Update tools's copy of asm-generic/unistd.h
>       tools headers uapi: Update tools's copy of drm/drm.h
>       tools headers uapi: Update tools's copies of kvm headers
>       tools headers uapi: Update tools's copy of linux/vhost.h
>       tools headers uapi: Update tools's copy of linux/if_link.h
> 
>  tools/arch/arm/include/uapi/asm/kvm.h   | 13 ++++++++++++
>  tools/arch/arm64/include/uapi/asm/kvm.h | 13 ++++++++++++
>  tools/arch/s390/include/uapi/asm/kvm.h  |  5 ++++-
>  tools/arch/x86/include/uapi/asm/kvm.h   | 37 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/asm-generic/unistd.h |  4 +++-
>  tools/include/uapi/drm/drm.h            |  9 ++++++++
>  tools/include/uapi/linux/if_link.h      | 17 +++++++++++++++
>  tools/include/uapi/linux/kvm.h          |  6 ++++++
>  tools/include/uapi/linux/perf_event.h   |  2 +-
>  tools/include/uapi/linux/vhost.h        | 18 ++++++++++++++++
>  tools/perf/util/map.c                   | 11 ++++++++++
>  11 files changed, 132 insertions(+), 3 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
