Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C7318EDA
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123596; cv=none; b=Y+Zqhy3Su6cOEhcx9de+9ZWM+Ku2Dm6+prUJFOrL/9FZDzxwPCXZ5E5I8CZ7qy+WkskeTfTH8hEvK+4uOdXdKr+ij64vnLT8PGSEJPGnn/KUghM/Huq8g5uVJ1q7DgBGDp9IH5odgfqPROX5lNIl6xcHJTgCqm/VK6Jk4qoFoRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123596; c=relaxed/simple;
	bh=c7Ux3Y4oBKWCT3MZoygJWIz84lJaLHkZAtdLU06/qn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHXhK6xeqWOpfPBAjGjpymrKa7tZ81nGL+zvcATTiz+uOIv8vEDy/nyBGiTHG9qvgbeI4EI+89LgBXzsdcJg0L3YAHuoKM484F/QCnsYIPmbzzjuQrA9R6gJDl8OLCdSbHzYObtGhEFr15V6bSREWlFUCl3RCqpxSK0rfk6JxVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgT2O+9A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgT2O+9A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784123592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUIQVFWz/6HX0LXQ2LfuttAZGzqa1laC8h1PL/eYtC0=;
	b=TgT2O+9AbU6OfxCcRXJMRPoyvoJVkPn9JExi+P46SN8wo2Xycv+5jAmftbLQPtaeUCnPJo
	z7jhvzP4zUrnat1vT80NB8K1b4kx+CdEwzFZlrT6Op7J0/OiDNlRCX3TAJYKBKV7fpeCXw
	apXNIhSzwnqF8FVQf5x9WxONyph1Icc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-DQPCm83kNf233xB0k5e_iw-1; Wed,
 15 Jul 2026 09:53:09 -0400
X-MC-Unique: DQPCm83kNf233xB0k5e_iw-1
X-Mimecast-MFC-AGG-ID: DQPCm83kNf233xB0k5e_iw_1784123587
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D3D01800673;
	Wed, 15 Jul 2026 13:53:06 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.80.235])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 257281956089;
	Wed, 15 Jul 2026 13:53:03 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: rostedt@goodmis.org,
	acme@kernel.org,
	peterz@infradead.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Fuad Tabba <tabba@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Subject: [PATCH v5 2/5] tracefs: add read-only eventfs filesystem at /sys/kernel/events
Date: Wed, 15 Jul 2026 09:52:23 -0400
Message-ID: <20260715135231.338535-4-ashelat@redhat.com>
In-Reply-To: <20260715135231.338535-2-ashelat@redhat.com>
References: <20260715135231.338535-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Introduce a new read-only pseudo-filesystem "eventfs" mounted at
/sys/kernel/events that exposes trace event format and id files
(mode 0444) to unprivileged users. This allows tools like perf to
discover event formats without requiring access to the full
tracefs/debugfs mount.

The eventfs filesystem reuses the existing eventfs_inode lazy-lookup
infrastructure. A new set of super_operations
(eventfs_ro_super_operations) shares the tracefs inode allocator so
that eventfs_get_inode() and get_tracefs() work on the RO superblock.
The superblock is manually initialized to ensure the root inode is
allocated with tracefs_alloc_inode, allowing the root to serve
directly as the events directory without another events subdirectory.

Each qualifying event gets a subsystem directory containing format
and id files. The top-level events directory also exposes header_page
and header_event. Similar to tracefs, a change will need to be made in
systemd to mount this filesystem automatically.

Assisted-by: CLAUDE:claude-opus-4 Apogee
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 fs/tracefs/event_inode.c     | 61 +++++++++++++++++++++++
 fs/tracefs/inode.c           | 95 +++++++++++++++++++++++++++++++++++-
 fs/tracefs/internal.h        |  3 ++
 include/linux/trace_events.h |  1 +
 include/linux/tracefs.h      |  4 ++
 include/uapi/linux/magic.h   |  1 +
 kernel/trace/trace.h         |  2 +
 kernel/trace/trace_events.c  | 87 +++++++++++++++++++++++++++++++++
 8 files changed, 252 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 39c7a34531e8..fd6f63ec3ce0 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -812,6 +812,67 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ERR_PTR(-ENOMEM);
 }
 
+/**
+ * eventfs_create_events_dir_ro - create a read-only events directory
+ * @name: The name of the top level directory to create.
+ * @entries: A list of entries that represent the files under this directory
+ * @size: The number of @entries
+ * @data: The default data to pass to the files (an entry may override it).
+ *
+ * This function configures the eventfs filesystem root as a read-only
+ * trace event directory using the existing eventfs_inode lazy-lookup
+ * infrastructure.
+ *
+ * See eventfs_create_dir() for use of @entries.
+ */
+struct eventfs_inode *eventfs_create_events_dir_ro(const char *name,
+						   const struct eventfs_entry *entries,
+						   int size, void *data)
+{
+	struct dentry *dentry;
+	struct eventfs_root_inode *rei;
+	struct eventfs_inode *ei;
+	struct tracefs_inode *ti;
+	struct inode *inode;
+
+	dentry = eventfs_ro_get_root();
+	if (IS_ERR(dentry))
+		return ERR_CAST(dentry);
+
+	inode = d_inode(dentry);
+
+	ei = alloc_root_ei(name);
+	if (!ei)
+		goto fail;
+
+	rei = get_root_inode(ei);
+	rei->events_dir = dentry;
+
+	ei->entries = entries;
+	ei->nr_entries = size;
+	ei->data = data;
+
+	INIT_LIST_HEAD(&ei->children);
+	INIT_LIST_HEAD(&ei->list);
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+	ti->private = ei;
+
+	inode->i_op = &eventfs_dir_inode_operations;
+	inode->i_fop = &eventfs_file_operations;
+
+	dentry->d_fsdata = get_ei(ei);
+
+	return ei;
+
+ fail:
+	cleanup_ei(ei);
+	dput(dentry);
+	eventfs_ro_put_root();
+	return ERR_PTR(-ENOMEM);
+}
+
 /**
  * eventfs_remove_rec - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index f3d6188a3b7b..fd064d79d940 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -30,6 +30,9 @@ static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
+static struct vfsmount *eventfs_ro_mount;
+static int eventfs_ro_mount_count;
+
 /*
  * Keep track of all tracefs_inodes in order to update their
  * flags if necessary on a remount.
@@ -423,6 +426,14 @@ static const struct super_operations tracefs_super_operations = {
 	.show_options	= tracefs_show_options,
 };
 
+static const struct super_operations eventfs_ro_super_operations = {
+	.alloc_inode    = tracefs_alloc_inode,
+	.free_inode     = tracefs_free_inode,
+	.destroy_inode  = tracefs_destroy_inode,
+	.drop_inode     = tracefs_drop_inode,
+	.statfs		= simple_statfs,
+};
+
 /*
  * It would be cleaner if eventfs had its own dentry ops.
  *
@@ -523,6 +534,79 @@ static struct file_system_type trace_fs_type = {
 };
 MODULE_ALIAS_FS("tracefs");
 
+static int eventfs_ro_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct inode *inode;
+	struct dentry *root;
+
+	sb->s_blocksize = PAGE_SIZE;
+	sb->s_blocksize_bits = PAGE_SHIFT;
+	sb->s_magic = EVENTFS_SUPER_MAGIC;
+	sb->s_op = &eventfs_ro_super_operations;
+	sb->s_time_gran = 1;
+	sb->s_flags |= SB_RDONLY;
+
+	inode = new_inode(sb);
+	if (!inode)
+		return -ENOMEM;
+
+	inode->i_ino = 1;
+	inode->i_mode = S_IFDIR | 0555;
+	simple_inode_init_ts(inode);
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	set_nlink(inode, 2);
+
+	set_default_d_op(sb, &tracefs_dentry_operations);
+
+	root = d_make_root(inode);
+	if (!root)
+		return -ENOMEM;
+
+	sb->s_root = root;
+
+	return 0;
+}
+
+static int eventfs_ro_get_tree(struct fs_context *fc)
+{
+	return get_tree_single(fc, eventfs_ro_fill_super);
+}
+
+static const struct fs_context_operations eventfs_ro_context_ops = {
+	.get_tree	= eventfs_ro_get_tree,
+};
+
+static int eventfs_ro_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &eventfs_ro_context_ops;
+	return 0;
+}
+
+static struct file_system_type eventfs_ro_fs_type = {
+	.owner =	THIS_MODULE,
+	.name =		"eventfs",
+	.init_fs_context = eventfs_ro_init_fs_context,
+	.kill_sb =	kill_anon_super,
+};
+
+struct dentry *eventfs_ro_get_root(void)
+{
+	int error;
+
+	error = simple_pin_fs(&eventfs_ro_fs_type, &eventfs_ro_mount,
+			      &eventfs_ro_mount_count);
+	if (error)
+		return ERR_PTR(error);
+
+	return dget(eventfs_ro_mount->mnt_root);
+}
+
+void eventfs_ro_put_root(void)
+{
+	simple_release_fs(&eventfs_ro_mount, &eventfs_ro_mount_count);
+}
+
 struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
 {
 	struct dentry *dentry;
@@ -801,8 +885,15 @@ static int __init tracefs_init(void)
 		return -EINVAL;
 
 	retval = register_filesystem(&trace_fs_type);
-	if (!retval)
-		tracefs_registered = true;
+	if (retval)
+		return retval;
+	tracefs_registered = true;
+
+	retval = sysfs_create_mount_point(kernel_kobj, "events");
+	if (retval)
+		return retval;
+
+	retval = register_filesystem(&eventfs_ro_fs_type);
 
 	return retval;
 }
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index a4a7f8431aff..0440413f959b 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -73,6 +73,9 @@ struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
 
+struct dentry *eventfs_ro_get_root(void);
+void eventfs_ro_put_root(void);
+
 void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid);
 void eventfs_d_release(struct dentry *dentry);
 
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 308c76b57d13..957695fbb015 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -648,6 +648,7 @@ struct trace_event_file {
 	struct trace_event_call		*event_call;
 	struct event_filter __rcu	*filter;
 	struct eventfs_inode		*ei;
+	struct eventfs_inode		*ei_ro;
 	struct trace_array		*tr;
 	struct trace_subsystem_dir	*system;
 	struct list_head		triggers;
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index bc354d340046..c175efc51d20 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -87,6 +87,10 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 					 const struct eventfs_entry *entries,
 					 int size, void *data);
 
+struct eventfs_inode *eventfs_create_events_dir_ro(const char *name,
+						   const struct eventfs_entry *entries,
+						   int size, void *data);
+
 void eventfs_remove_events_dir(struct eventfs_inode *ei);
 void eventfs_remove_dir(struct eventfs_inode *ei);
 
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 4f2da935a76c..7cf8f1a1ae38 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -75,6 +75,7 @@
 #define STACK_END_MAGIC		0x57AC6E9D
 
 #define TRACEFS_MAGIC          0x74726163
+#define EVENTFS_SUPER_MAGIC    0x65766673
 
 #define V9FS_MAGIC		0x01021997
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..00c35aaa5069 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -416,6 +416,7 @@ struct trace_array {
 	struct dentry		*options;
 	struct dentry		*percpu_dir;
 	struct eventfs_inode	*event_dir;
+	struct eventfs_inode	*event_dir_ro;
 	struct trace_options	*topts;
 	struct list_head	systems;
 	struct list_head	events;
@@ -1604,6 +1605,7 @@ struct trace_subsystem_dir {
 	struct event_subsystem		*subsystem;
 	struct trace_array		*tr;
 	struct eventfs_inode		*ei;
+	struct eventfs_inode		*ei_ro;
 	int				ref_count;
 	int				nr_events;
 };
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index ddb6932a3ee7..9662cb24a92c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1279,6 +1279,7 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 
 	if (!--dir->nr_events) {
 		eventfs_remove_dir(dir->ei);
+		eventfs_remove_dir(dir->ei_ro);
 		list_del(&dir->list);
 		__put_system_dir(dir);
 	}
@@ -1308,6 +1309,7 @@ void event_file_put(struct trace_event_file *file)
 static void remove_event_file_dir(struct trace_event_file *file)
 {
 	eventfs_remove_dir(file->ei);
+	eventfs_remove_dir(file->ei_ro);
 	list_del(&file->list);
 	remove_subsystem(file->system);
 	free_event_filter(file->filter);
@@ -2986,6 +2988,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	}
 
 	dir->ei = ei;
+	dir->ei_ro = NULL;
 	dir->tr = tr;
 	dir->ref_count = 1;
 	dir->nr_events = 1;
@@ -3126,6 +3129,33 @@ static void event_release(const char *name, void *data)
 	event_file_put(file);
 }
 
+static int event_callback_ro(const char *name, umode_t *mode, void **data,
+			     const struct file_operations **fops)
+{
+	int ret = event_callback(name, mode, data, fops);
+
+	/* Skip writable entries in the read-only tree */
+	if (ret && (*mode & 0222))
+		return 0;
+	if (ret)
+		*mode = 0444;
+	return ret;
+}
+
+static struct eventfs_entry event_entries_ro[] = {
+	{
+		.name		= "format",
+		.callback	= event_callback_ro,
+		.release	= event_release,
+	},
+#ifdef CONFIG_PERF_EVENTS
+	{
+		.name		= "id",
+		.callback	= event_callback_ro,
+	},
+#endif
+};
+
 static int
 event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 {
@@ -3218,6 +3248,28 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 	/* Gets decremented on freeing of the "enable" file */
 	event_file_get(file);
 
+	/* Create read only eventfs directory */
+	if (!(call->flags & TRACE_EVENT_FL_DYNAMIC) &&
+	    !IS_ERR_OR_NULL(tr->event_dir_ro)) {
+		struct trace_subsystem_dir *sdir = file->system;
+
+		if (!sdir->ei_ro) {
+			sdir->ei_ro = eventfs_create_dir(call->class->system,
+					tr->event_dir_ro, NULL, 0, sdir);
+			if (IS_ERR(sdir->ei_ro))
+				sdir->ei_ro = NULL;
+		}
+		if (sdir->ei_ro) {
+			file->ei_ro = eventfs_create_dir(name, sdir->ei_ro,
+					event_entries_ro,
+					ARRAY_SIZE(event_entries_ro), file);
+			if (IS_ERR(file->ei_ro))
+				file->ei_ro = NULL;
+			else
+				event_file_get(file);
+		}
+	}
+
 	return 0;
 }
 
@@ -4539,10 +4591,35 @@ static int events_callback(const char *name, umode_t *mode, void **data,
 	return 1;
 }
 
+static int events_callback_ro(const char *name, umode_t *mode, void **data,
+			      const struct file_operations **fops)
+{
+	int ret = events_callback(name, mode, data, fops);
+
+	/* Skip writable entries in the read-only tree */
+	if (ret && (*mode & 0222))
+		return 0;
+	if (ret)
+		*mode = 0444;
+	return ret;
+}
+
+static struct eventfs_entry events_entries_ro[] = {
+	{
+		.name		= "header_page",
+		.callback	= events_callback_ro,
+	},
+	{
+		.name		= "header_event",
+		.callback	= events_callback_ro,
+	},
+};
+
 /* Expects to have event_mutex held when called */
 static int
 create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 {
+	static bool event_dir_ro_created;
 	struct eventfs_inode *e_events;
 	struct dentry *entry;
 	int nr_entries;
@@ -4596,6 +4673,16 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 
 	tr->event_dir = e_events;
 
+	if (!event_dir_ro_created && (tr->flags & TRACE_ARRAY_FL_GLOBAL)) {
+		tr->event_dir_ro = eventfs_create_events_dir_ro(
+				"events", events_entries_ro,
+				ARRAY_SIZE(events_entries_ro), tr);
+		if (IS_ERR(tr->event_dir_ro))
+			tr->event_dir_ro = NULL;
+		else
+			event_dir_ro_created = true;
+	}
+
 	return 0;
 }
 
-- 
2.54.0

