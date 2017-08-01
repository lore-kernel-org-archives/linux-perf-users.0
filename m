From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 16/18] tools include uapi: Grab a copy of linux/vhost.h
Date: Wed, 2 Aug 2017 00:19:18 +0300
Message-ID: <20170802001802-mutt-send-email-mst@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
 <20170801195645.16986-17-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170801195645.16986-17-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Aug 01, 2017 at 04:56:43PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> We will use it to generate tables for beautifying ioctl's 'cmd' arg.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Link: http://lkml.kernel.org/n/tip-nxwpq34hu6te1m2ra5m7o8n9@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Is this what tools/perf always does? Isn't there a way
to reuse the single header?

> ---
>  tools/include/uapi/linux/vhost.h | 209 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/MANIFEST              |   1 +
>  tools/perf/check-headers.sh      |   1 +
>  3 files changed, 211 insertions(+)
>  create mode 100644 tools/include/uapi/linux/vhost.h
> 
> diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
> new file mode 100644
> index 000000000000..60180c0b5dc6
> --- /dev/null
> +++ b/tools/include/uapi/linux/vhost.h
> @@ -0,0 +1,209 @@
> +#ifndef _LINUX_VHOST_H
> +#define _LINUX_VHOST_H
> +/* Userspace interface for in-kernel virtio accelerators. */
> +
> +/* vhost is used to reduce the number of system calls involved in virtio.
> + *
> + * Existing virtio net code is used in the guest without modification.
> + *
> + * This header includes interface used by userspace hypervisor for
> + * device configuration.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/compiler.h>
> +#include <linux/ioctl.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ring.h>
> +
> +struct vhost_vring_state {
> +	unsigned int index;
> +	unsigned int num;
> +};
> +
> +struct vhost_vring_file {
> +	unsigned int index;
> +	int fd; /* Pass -1 to unbind from file. */
> +
> +};
> +
> +struct vhost_vring_addr {
> +	unsigned int index;
> +	/* Option flags. */
> +	unsigned int flags;
> +	/* Flag values: */
> +	/* Whether log address is valid. If set enables logging. */
> +#define VHOST_VRING_F_LOG 0
> +
> +	/* Start of array of descriptors (virtually contiguous) */
> +	__u64 desc_user_addr;
> +	/* Used structure address. Must be 32 bit aligned */
> +	__u64 used_user_addr;
> +	/* Available structure address. Must be 16 bit aligned */
> +	__u64 avail_user_addr;
> +	/* Logging support. */
> +	/* Log writes to used structure, at offset calculated from specified
> +	 * address. Address must be 32 bit aligned. */
> +	__u64 log_guest_addr;
> +};
> +
> +/* no alignment requirement */
> +struct vhost_iotlb_msg {
> +	__u64 iova;
> +	__u64 size;
> +	__u64 uaddr;
> +#define VHOST_ACCESS_RO      0x1
> +#define VHOST_ACCESS_WO      0x2
> +#define VHOST_ACCESS_RW      0x3
> +	__u8 perm;
> +#define VHOST_IOTLB_MISS           1
> +#define VHOST_IOTLB_UPDATE         2
> +#define VHOST_IOTLB_INVALIDATE     3
> +#define VHOST_IOTLB_ACCESS_FAIL    4
> +	__u8 type;
> +};
> +
> +#define VHOST_IOTLB_MSG 0x1
> +
> +struct vhost_msg {
> +	int type;
> +	union {
> +		struct vhost_iotlb_msg iotlb;
> +		__u8 padding[64];
> +	};
> +};
> +
> +struct vhost_memory_region {
> +	__u64 guest_phys_addr;
> +	__u64 memory_size; /* bytes */
> +	__u64 userspace_addr;
> +	__u64 flags_padding; /* No flags are currently specified. */
> +};
> +
> +/* All region addresses and sizes must be 4K aligned. */
> +#define VHOST_PAGE_SIZE 0x1000
> +
> +struct vhost_memory {
> +	__u32 nregions;
> +	__u32 padding;
> +	struct vhost_memory_region regions[0];
> +};
> +
> +/* ioctls */
> +
> +#define VHOST_VIRTIO 0xAF
> +
> +/* Features bitmask for forward compatibility.  Transport bits are used for
> + * vhost specific features. */
> +#define VHOST_GET_FEATURES	_IOR(VHOST_VIRTIO, 0x00, __u64)
> +#define VHOST_SET_FEATURES	_IOW(VHOST_VIRTIO, 0x00, __u64)
> +
> +/* Set current process as the (exclusive) owner of this file descriptor.  This
> + * must be called before any other vhost command.  Further calls to
> + * VHOST_OWNER_SET fail until VHOST_OWNER_RESET is called. */
> +#define VHOST_SET_OWNER _IO(VHOST_VIRTIO, 0x01)
> +/* Give up ownership, and reset the device to default values.
> + * Allows subsequent call to VHOST_OWNER_SET to succeed. */
> +#define VHOST_RESET_OWNER _IO(VHOST_VIRTIO, 0x02)
> +
> +/* Set up/modify memory layout */
> +#define VHOST_SET_MEM_TABLE	_IOW(VHOST_VIRTIO, 0x03, struct vhost_memory)
> +
> +/* Write logging setup. */
> +/* Memory writes can optionally be logged by setting bit at an offset
> + * (calculated from the physical address) from specified log base.
> + * The bit is set using an atomic 32 bit operation. */
> +/* Set base address for logging. */
> +#define VHOST_SET_LOG_BASE _IOW(VHOST_VIRTIO, 0x04, __u64)
> +/* Specify an eventfd file descriptor to signal on log write. */
> +#define VHOST_SET_LOG_FD _IOW(VHOST_VIRTIO, 0x07, int)
> +
> +/* Ring setup. */
> +/* Set number of descriptors in ring. This parameter can not
> + * be modified while ring is running (bound to a device). */
> +#define VHOST_SET_VRING_NUM _IOW(VHOST_VIRTIO, 0x10, struct vhost_vring_state)
> +/* Set addresses for the ring. */
> +#define VHOST_SET_VRING_ADDR _IOW(VHOST_VIRTIO, 0x11, struct vhost_vring_addr)
> +/* Base value where queue looks for available descriptors */
> +#define VHOST_SET_VRING_BASE _IOW(VHOST_VIRTIO, 0x12, struct vhost_vring_state)
> +/* Get accessor: reads index, writes value in num */
> +#define VHOST_GET_VRING_BASE _IOWR(VHOST_VIRTIO, 0x12, struct vhost_vring_state)
> +
> +/* Set the vring byte order in num. Valid values are VHOST_VRING_LITTLE_ENDIAN
> + * or VHOST_VRING_BIG_ENDIAN (other values return -EINVAL).
> + * The byte order cannot be changed while the device is active: trying to do so
> + * returns -EBUSY.
> + * This is a legacy only API that is simply ignored when VIRTIO_F_VERSION_1 is
> + * set.
> + * Not all kernel configurations support this ioctl, but all configurations that
> + * support SET also support GET.
> + */
> +#define VHOST_VRING_LITTLE_ENDIAN 0
> +#define VHOST_VRING_BIG_ENDIAN 1
> +#define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
> +#define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
> +
> +/* The following ioctls use eventfd file descriptors to signal and poll
> + * for events. */
> +
> +/* Set eventfd to poll for added buffers */
> +#define VHOST_SET_VRING_KICK _IOW(VHOST_VIRTIO, 0x20, struct vhost_vring_file)
> +/* Set eventfd to signal when buffers have beed used */
> +#define VHOST_SET_VRING_CALL _IOW(VHOST_VIRTIO, 0x21, struct vhost_vring_file)
> +/* Set eventfd to signal an error */
> +#define VHOST_SET_VRING_ERR _IOW(VHOST_VIRTIO, 0x22, struct vhost_vring_file)
> +/* Set busy loop timeout (in us) */
> +#define VHOST_SET_VRING_BUSYLOOP_TIMEOUT _IOW(VHOST_VIRTIO, 0x23,	\
> +					 struct vhost_vring_state)
> +/* Get busy loop timeout (in us) */
> +#define VHOST_GET_VRING_BUSYLOOP_TIMEOUT _IOW(VHOST_VIRTIO, 0x24,	\
> +					 struct vhost_vring_state)
> +
> +/* VHOST_NET specific defines */
> +
> +/* Attach virtio net ring to a raw socket, or tap device.
> + * The socket must be already bound to an ethernet device, this device will be
> + * used for transmit.  Pass fd -1 to unbind from the socket and the transmit
> + * device.  This can be used to stop the ring (e.g. for migration). */
> +#define VHOST_NET_SET_BACKEND _IOW(VHOST_VIRTIO, 0x30, struct vhost_vring_file)
> +
> +/* Feature bits */
> +/* Log all write descriptors. Can be changed while device is active. */
> +#define VHOST_F_LOG_ALL 26
> +/* vhost-net should add virtio_net_hdr for RX, and strip for TX packets. */
> +#define VHOST_NET_F_VIRTIO_NET_HDR 27
> +
> +/* VHOST_SCSI specific definitions */
> +
> +/*
> + * Used by QEMU userspace to ensure a consistent vhost-scsi ABI.
> + *
> + * ABI Rev 0: July 2012 version starting point for v3.6-rc merge candidate +
> + *            RFC-v2 vhost-scsi userspace.  Add GET_ABI_VERSION ioctl usage
> + * ABI Rev 1: January 2013. Ignore vhost_tpgt filed in struct vhost_scsi_target.
> + *            All the targets under vhost_wwpn can be seen and used by guset.
> + */
> +
> +#define VHOST_SCSI_ABI_VERSION	1
> +
> +struct vhost_scsi_target {
> +	int abi_version;
> +	char vhost_wwpn[224]; /* TRANSPORT_IQN_LEN */
> +	unsigned short vhost_tpgt;
> +	unsigned short reserved;
> +};
> +
> +#define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_scsi_target)
> +#define VHOST_SCSI_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x41, struct vhost_scsi_target)
> +/* Changing this breaks userspace. */
> +#define VHOST_SCSI_GET_ABI_VERSION _IOW(VHOST_VIRTIO, 0x42, int)
> +/* Set and get the events missed flag */
> +#define VHOST_SCSI_SET_EVENTS_MISSED _IOW(VHOST_VIRTIO, 0x43, __u32)
> +#define VHOST_SCSI_GET_EVENTS_MISSED _IOW(VHOST_VIRTIO, 0x44, __u32)
> +
> +/* VHOST_VSOCK specific defines */
> +
> +#define VHOST_VSOCK_SET_GUEST_CID	_IOW(VHOST_VIRTIO, 0x60, __u64)
> +#define VHOST_VSOCK_SET_RUNNING		_IOW(VHOST_VIRTIO, 0x61, int)
> +
> +#endif
> diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
> index 513f52a484fd..62072822dc85 100644
> --- a/tools/perf/MANIFEST
> +++ b/tools/perf/MANIFEST
> @@ -85,6 +85,7 @@ tools/include/uapi/linux/mman.h
>  tools/include/uapi/linux/perf_event.h
>  tools/include/uapi/linux/sched.h
>  tools/include/uapi/linux/stat.h
> +tools/include/uapi/linux/vhost.h
>  tools/include/uapi/sound/asound.h
>  tools/include/linux/poison.h
>  tools/include/linux/rbtree.h
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 1f009506ff63..932fda54b8a6 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -8,6 +8,7 @@ include/uapi/linux/kvm.h
>  include/uapi/linux/perf_event.h
>  include/uapi/linux/sched.h
>  include/uapi/linux/stat.h
> +include/uapi/linux/vhost.h
>  include/uapi/sound/asound.h
>  include/linux/hash.h
>  include/uapi/linux/hw_breakpoint.h
> -- 
> 2.9.4
